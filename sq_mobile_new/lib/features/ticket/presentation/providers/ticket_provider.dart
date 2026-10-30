// lib/features/ticket/presentation/providers/ticket_provider.dart
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/api/socket_service.dart';
import 'package:smartqueue/core/mock/mock_providers.dart';
import 'package:smartqueue/core/mock/mock_data.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
import 'package:smartqueue/features/ticket/data/ticket_repository.dart';

part 'ticket_provider.g.dart';

// ── Stream ticket temps réel ──────────────────────────────────────────────────
@riverpod
Stream<TicketModel> ticketStream(TicketStreamRef ref, String ticketId) {
  if (kMockMode) {
    // StreamProvider retourne AsyncValue — on le convertit en Stream
    final ctrl = StreamController<TicketModel>.broadcast();
    int position = 4;
    TicketStatus status = TicketStatus.waiting;

    ctrl.add(buildMockTicket(position: position, status: status));

    Timer? timer;
    timer = Timer.periodic(const Duration(seconds: 8), (_) {
      if (ctrl.isClosed) { timer?.cancel(); return; }
      if (status == TicketStatus.waiting && position > 1) {
        position--;
        ctrl.add(buildMockTicket(position: position, status: status));
      } else if (status == TicketStatus.waiting && position == 1) {
        status = TicketStatus.called;
        ctrl.add(buildMockTicket(position: 0, status: status));
      }
    });

    ref.onDispose(() { timer?.cancel(); ctrl.close(); });
    return ctrl.stream;
  }

  // Mode réel — Socket.IO
  final repo   = ref.watch(ticketRepositoryProvider);
  final socket = ref.watch(socketServiceProvider);
  final ctrl   = StreamController<TicketModel>.broadcast();

  repo.getTicket(ticketId).then(ctrl.add, onError: ctrl.addError);
  socket.joinTicket(ticketId);

  void refresh(dynamic _) {
    repo.getTicket(ticketId).then(ctrl.add, onError: ctrl.addError);
  }
  socket.on('ticket:called',  refresh);
  socket.on('ticket:updated', refresh);

  ref.onDispose(() {
    socket.off('ticket:called',  refresh);
    socket.off('ticket:updated', refresh);
    socket.leaveTicket(ticketId);
    ctrl.close();
  });
  return ctrl.stream;
}

// ── Créer ticket ──────────────────────────────────────────────────────────────
@riverpod
class CreateTicketNotifier extends _$CreateTicketNotifier {
  @override
  AsyncValue<TicketModel?> build() => const AsyncValue.data(null);

  Future<TicketModel?> create(CreateTicketDto dto) async {
    state = const AsyncValue.loading();
    if (kMockMode) {
      final ticket = await ref
          .read(mockCreateTicketProvider.notifier)
          .create(dto);
      state = AsyncValue.data(ticket);
      return ticket;
    }
    state = await AsyncValue.guard(
        () => ref.read(ticketRepositoryProvider).createTicket(dto));
    return state.value;
  }
}

// ── Annuler ticket ────────────────────────────────────────────────────────────
@riverpod
class CancelTicketNotifier extends _$CancelTicketNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> cancel(String id, {String? reason}) async {
    state = const AsyncValue.loading();
    if (kMockMode) {
      await ref.read(mockCancelTicketProvider.notifier)
          .cancel(id, reason: reason);
      state = const AsyncValue.data(null);
      return;
    }
    state = await AsyncValue.guard(
        () => ref.read(ticketRepositoryProvider)
            .cancelTicket(id, reason: reason));
  }
}

// ── Historique ────────────────────────────────────────────────────────────────
@riverpod
Future<List<TicketModel>> myTickets(MyTicketsRef ref, {String? status}) {
  if (kMockMode) {
    return ref.watch(mockTicketHistoryDataProvider(status: status).future);
  }
  return ref.watch(ticketRepositoryProvider).getMyTickets(status: status);
}

// ── Feedback ──────────────────────────────────────────────────────────────────
@riverpod
class FeedbackNotifier extends _$FeedbackNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> submit({
    required String ticketId,
    required int rating,
    String? comment,
    List<String> tags = const [],
  }) async {
    state = const AsyncValue.loading();
    if (kMockMode) {
      await ref.read(mockFeedbackProvider.notifier).submit(
          ticketId: ticketId, rating: rating,
          comment: comment, tags: tags);
      state = const AsyncValue.data(null);
      return;
    }
    state = await AsyncValue.guard(
        () => ref.read(ticketRepositoryProvider).submitFeedback(
            ticketId: ticketId, rating: rating,
            comment: comment, tags: tags));
  }
}
