// lib/core/mock/mock_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/mock/mock_data.dart';
import 'package:smartqueue/features/auth/data/auth_models.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';

part 'mock_providers.g.dart';

// ── Flag global ───────────────────────────────────────────────────────────────
const bool kMockMode = false;

// ── Auth ──────────────────────────────────────────────────────────────────────
@riverpod
class MockAuthNotifier extends _$MockAuthNotifier {
  @override
  AsyncValue<UserModel?> build() => const AsyncValue.data(null);

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 800));
    state = AsyncValue.data(mockUser.copyWith(
      email: email,
      firstName: email.split('@').first.capitalize(),
    ));
    return true;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 1000));
    state = AsyncValue.data(mockUser.copyWith(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    ));
    return true;
  }

  void logout() => state = const AsyncValue.data(null);
}

// ── Recherche organisations ───────────────────────────────────────────────────
@riverpod
Future<List<OrganizationCard>> mockOrganizationSearch(
  MockOrganizationSearchRef ref, {
  String? query,
  String? type,
  String? city,
}) async {
  await Future.delayed(const Duration(milliseconds: 600));
  var results = [...mockOrganizations];
  if (query != null && query.isNotEmpty) {
    final q = query.toLowerCase();
    results = results
        .where((o) =>
            o.name.toLowerCase().contains(q) ||
            (o.city?.toLowerCase().contains(q) ?? false))
        .toList();
  }
  if (type != null) {
    results = results.where((o) => o.type == type).toList();
  }
  if (city != null && city.isNotEmpty) {
    results = results
        .where((o) =>
            o.city?.toLowerCase().contains(city.toLowerCase()) ?? false)
        .toList();
  }
  return results;
}

// ── Favoris ───────────────────────────────────────────────────────────────────
@riverpod
Future<List<OrganizationCard>> mockFavoritesData(
    MockFavoritesDataRef ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return mockFavorites;
}

// ── Détail agence ─────────────────────────────────────────────────────────────
@riverpod
Future<BranchDetail> mockBranchData(
    MockBranchDataRef ref, String branchId) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return mockBranchDetail.copyWith(id: branchId);
}

// ── Historique tickets ────────────────────────────────────────────────────────
@riverpod
Future<List<TicketModel>> mockTicketHistoryData(
  MockTicketHistoryDataRef ref, {
  String? status,
}) async {
  await Future.delayed(const Duration(milliseconds: 500));
  final all = mockTicketHistory;
  if (status == null) return all;
  final statuses = status.toLowerCase().split(',');
  return all
      .where((t) => statuses.contains(t.status.name.toLowerCase()))
      .toList();
}

// ── Créer ticket ──────────────────────────────────────────────────────────────
@riverpod
class MockCreateTicket extends _$MockCreateTicket {
  @override
  AsyncValue<TicketModel?> build() => const AsyncValue.data(null);

  Future<TicketModel?> create(CreateTicketDto dto) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 900));
    final ticket = buildMockTicket(position: 5, status: TicketStatus.waiting);
    state = AsyncValue.data(ticket);
    return ticket;
  }
}

// ── Annuler ticket ────────────────────────────────────────────────────────────
@riverpod
class MockCancelTicket extends _$MockCancelTicket {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> cancel(String id, {String? reason}) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 600));
    state = const AsyncValue.data(null);
  }
}

// ── Feedback ──────────────────────────────────────────────────────────────────
@riverpod
class MockFeedback extends _$MockFeedback {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> submit({
    required String ticketId,
    required int rating,
    String? comment,
    List<String> tags = const [],
  }) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 700));
    state = const AsyncValue.data(null);
  }
}

// ── Extension helper ──────────────────────────────────────────────────────────
extension StringX on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
