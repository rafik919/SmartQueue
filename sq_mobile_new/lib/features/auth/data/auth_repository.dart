// lib/features/auth/data/auth_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/api/api_client.dart';
import 'package:smartqueue/core/constants/app_constants.dart';
import 'package:smartqueue/features/auth/data/auth_models.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepository(ref.watch(dioProvider));

class AuthRepository {
  AuthRepository(this._dio);
  final Dio _dio;
  static const _storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  Future<AuthResponse> register({
    required String email, required String password,
    required String firstName, required String lastName, String? phone,
  }) async {
    try {
      final res = await _dio.post('/auth/register', data: {
        'email': email, 'password': password,
        'firstName': firstName, 'lastName': lastName,
        if (phone != null) 'phone': phone,
      });
      final auth = AuthResponse.fromJson(res.data['data'] as Map<String, dynamic>);
      await _save(auth.tokens);
      return auth;
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<AuthResponse> login({required String email, required String password}) async {
    try {
      final res = await _dio.post('/auth/login', data: {'email': email, 'password': password});
      final auth = AuthResponse.fromJson(res.data['data'] as Map<String, dynamic>);
      await _save(auth.tokens);
      return auth;
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<void> logout() async {
    try {
      final rt = await _storage.read(key: AppConstants.refreshTokenKey);
      if (rt != null) await _dio.post('/auth/logout', data: {'refreshToken': rt});
    } finally { await _clear(); }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final res = await _dio.get('/auth/me');
      return UserModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) return null;
      throw AppException.fromDio(e);
    }
  }

  Future<bool> isAuthenticated() async =>
      (await _storage.read(key: AppConstants.accessTokenKey)) != null;

  Future<void> registerFcmToken(String token) async {
    try { await _dio.post('/users/me/fcm-token', data: {'token': token}); }
    catch (_) {}
  }

  Future<void> _save(AuthTokens t) async {
    await _storage.write(key: AppConstants.accessTokenKey,  value: t.accessToken);
    await _storage.write(key: AppConstants.refreshTokenKey, value: t.refreshToken);
  }

  Future<void> _clear() async {
    await _storage.delete(key: AppConstants.accessTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }
}
