// lib/features/home/data/home_repository.dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/api/api_client.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) =>
    HomeRepository(ref.watch(dioProvider));

class HomeRepository {
  HomeRepository(this._dio);
  final Dio _dio;

  Future<List<OrganizationCard>> searchOrganizations({
    String? query, String? city, String? type,
    double? lat, double? lng, int page = 1,
  }) async {
    try {
      final res = await _dio.get('/organizations', queryParameters: {
        if (query != null && query.isNotEmpty) 'q': query,
        if (city  != null && city.isNotEmpty)  'city': city,
        if (type  != null) 'type': type,
        if (lat   != null) 'lat': lat,
        if (lng   != null) 'lng': lng,
        'page': page, 'limit': 20,
      });
      // Backend renvoie { data: { items: [...], total, page } }
      final data = res.data['data'];
      final list = data is Map ? (data['items'] as List? ?? []) : (data as List? ?? []);
      return list
          .map((e) => OrganizationCard.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<BranchDetail> getBranchDetail(String id) async {
    try {
      final res = await _dio.get('/branches/$id');
      return BranchDetail.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<List<OrganizationCard>> getFavorites() async {
    try {
      final res = await _dio.get('/users/me/favorites');
      // Backend renvoie { data: [...] } directement une liste d'orgs
      final data = res.data['data'];
      final list = data is List ? data : (data is Map ? (data['items'] as List? ?? []) : []);
      return (list as List)
          .map((e) => OrganizationCard.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<void> toggleFavorite(String orgId, {required bool add}) async {
    try {
      if (add) await _dio.post('/users/me/favorites/$orgId');
      else     await _dio.delete('/users/me/favorites/$orgId');
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }
}