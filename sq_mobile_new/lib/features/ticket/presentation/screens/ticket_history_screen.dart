// lib/features/ticket/presentation/screens/ticket_history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
import 'package:smartqueue/features/ticket/presentation/providers/ticket_provider.dart';
import 'package:smartqueue/features/ticket/presentation/widgets/ticket_widgets.dart';

class TicketHistoryScreen extends ConsumerStatefulWidget {
  const TicketHistoryScreen({super.key});
  @override
  ConsumerState<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends ConsumerState<TicketHistoryScreen> {
  TicketStatus? _filter;
  static const _filters = [
    (null,                   'Tous'),
    (TicketStatus.completed, 'Terminés'),
    (TicketStatus.cancelled, 'Annulés'),
    (TicketStatus.missed,    'Manqués'),
  ];

  @override
  Widget build(BuildContext context) {
    final ticketsAsync = ref.watch(myTicketsProvider(
      status: _filter?.name.toUpperCase()));
    return Scaffold(
      appBar: AppBar(title: const Text('Mes tickets')),
      body: Column(children: [
        SizedBox(height: 48, child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final (status, label) = _filters[i];
            final sel = _filter == status;
            return GestureDetector(
              onTap: () => setState(() => _filter = status),
              child: AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: sel ? AppColors.accent.withOpacity(.15) : AppColors.bgSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: sel ? AppColors.accent : AppColors.border)),
                child: Text(label, style: TextStyle(
                  color: sel ? AppColors.accent : AppColors.textSecondary,
                  fontSize: 12.5, fontWeight: sel ? FontWeight.w600 : FontWeight.w400)),
              ),
            );
          },
        )),
        Expanded(child: ticketsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:   (e, _) => Center(child: Text(e.toString())),
          data:    (tickets) => tickets.isEmpty
            ? const _Empty()
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                itemCount: tickets.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _Item(ticket: tickets[i])
                  .animate(delay: (i * 40).ms).fadeIn().slideX(begin: .03),
              ),
        )),
      ]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.ticket});
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final isActive = ticket.status.isActive;
    return GestureDetector(
      onTap: isActive
        ? () => context.push('/ticket/${ticket.id}')
        : null,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.bgSurface, borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive ? AppColors.accent.withOpacity(.3) : AppColors.border)),
        child: Row(children: [
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.bgSurface2, borderRadius: BorderRadius.circular(8)),
            child: Text(ticket.code, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.accent)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(ticket.service.name, style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(ticket.branch.name,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
            const SizedBox(height: 3),
            Text(DateFormat('dd/MM/yyyy HH:mm').format(ticket.createdAt),
              style: const TextStyle(color: AppColors.textMuted, fontSize: 10.5)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TicketStatusBadge(status: ticket.status),
            if (ticket.waitDurationSec != null) ...[
              const SizedBox(height: 4),
              Text(
                ticket.waitDurationSec! < 60
                  ? '${ticket.waitDurationSec}s'
                  : '${ticket.waitDurationSec! ~/ 60}min d\'attente',
                style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
            ],
          ]),
        ]),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Padding(padding: EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.receipt_long_outlined, size: 52, color: AppColors.textMuted),
        SizedBox(height: 16),
        Text('Aucun ticket dans votre historique.', textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      ])));
  }
}
