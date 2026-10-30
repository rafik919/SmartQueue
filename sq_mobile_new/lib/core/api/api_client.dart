// lib/core/api/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/constants/app_constants.dart';
import 'package:logger/logger.dart';

part 'api_client.g.dart';

const _storage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);
final _log = Logger(printer: PrettyPrinter(methodCount: 0));

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.apiBaseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  ));
  dio.interceptors.addAll([_AuthInterceptor(dio), _LogInterceptor()]);
  return dio;
}

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._dio);
  final Dio _dio;
  bool _refreshing = false;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: AppConstants.accessTokenKey);
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_refreshing) {
      _refreshing = true;
      try {
        final ok = await _doRefresh();
        if (ok) {
          final token = await _storage.read(key: AppConstants.accessTokenKey);
          err.requestOptions.headers['Authorization'] = 'Bearer $token';
          final res = await _dio.fetch(err.requestOptions);
          _refreshing = false;
          return handler.resolve(res);
        }
      } catch (_) {
        await _storage.delete(key: AppConstants.accessTokenKey);
        await _storage.delete(key: AppConstants.refreshTokenKey);
        _refreshing = false;
      }
    }
    handler.next(err);
  }

  Future<bool> _doRefresh() async {
    try {
      final rt = await _storage.read(key: AppConstants.refreshTokenKey);
      if (rt == null) return false;
      final res = await Dio().post(
        '${AppConstants.apiBaseUrl}/auth/refresh',
        data: {'refreshToken': rt},
      );
      final tokens = res.data['data']['tokens'];
      await _storage.write(key: AppConstants.accessTokenKey,  value: tokens['accessToken']  as String);
      await _storage.write(key: AppConstants.refreshTokenKey, value: tokens['refreshToken'] as String);
      return true;
    } catch (_) { return false; }
  }
}

class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions o, RequestInterceptorHandler h) {
    _log.d('[API] ${o.method} ${o.path}'); h.next(o);
  }
  @override
  void onResponse(Response r, ResponseInterceptorHandler h) {
    _log.d('[API] ${r.statusCode} ${r.requestOptions.path}'); h.next(r);
  }
  @override
  void onError(DioException e, ErrorInterceptorHandler h) {
    _log.e('[API ERR] ${e.response?.statusCode} ${e.message}'); h.next(e);
  }
}

class AppException implements Exception {
  const AppException(this.message, {this.code, this.statusCode});
  final String message;
  final String? code;
  final int? statusCode;

  factory AppException.fromDio(DioException e) {
    final d = e.response?.data;
    if (d is Map && d['error'] != null) {
      return AppException(
        (d['error']['message'] ?? 'Erreur inconnue') as String,
        code: d['error']['code'] as String?,
        statusCode: e.response?.statusCode,
      );
    }
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.connectionError =>
        const AppException('Impossible de joindre le serveur.'),
      _ => AppException(e.message ?? 'Erreur réseau'),
    };
  }

  @override
  String toString() => message;
}
