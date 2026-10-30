// lib/features/ticket/data/ticket_repository.dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/api/api_client.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
part 'ticket_repository.g.dart';

@riverpod
TicketRepository ticketRepository(TicketRepositoryRef ref) =>
    TicketRepository(ref.watch(dioProvider));

class TicketRepository {
  TicketRepository(this._dio);
  final Dio _dio;

  Future<TicketModel> getTicket(String id) async {
    try {
      final res = await _dio.get('/tickets/$id');
      return TicketModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<List<TicketModel>> getMyTickets({String? status}) async {
    try {
      final res = await _dio.get('/users/me/tickets', queryParameters: {
        if (status != null) 'status': status,
      });
      // Backend renvoie { data: { items: [...], total } }
      final data = res.data['data'];
      final list = data is Map ? (data['items'] as List? ?? []) : (data as List? ?? []);
      return (list as List)
          .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<TicketModel> createTicket(CreateTicketDto dto) async {
    try {
      final res = await _dio.post('/tickets', data: dto.toJson());
      return TicketModel.fromJson(res.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<void> cancelTicket(String id, {String? reason}) async {
    try {
      await _dio.patch('/tickets/$id/cancel', data: {
        if (reason != null) 'reason': reason,
      });
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }

  Future<void> submitFeedback({
    required String ticketId,
    required int rating,
    String? comment,
    List<String> tags = const [],
  }) async {
    try {
      await _dio.post('/tickets/$ticketId/feedback', data: {
        'rating': rating,
        if (comment != null) 'comment': comment,
        if (tags.isNotEmpty) 'tags': tags,
      });
    } on DioException catch (e) { throw AppException.fromDio(e); }
  }
}