// lib/features/ticket/presentation/screens/active_ticket_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
import 'package:smartqueue/features/ticket/presentation/providers/ticket_provider.dart';
import 'package:smartqueue/features/ticket/presentation/widgets/ticket_widgets.dart';
import 'package:smartqueue/shared/widgets/sq_widgets.dart';

class ActiveTicketScreen extends ConsumerWidget {
  const ActiveTicketScreen({super.key, required this.ticketId});
  final String ticketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketStreamProvider(ticketId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon ticket'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.go(AppRoutes.home)),
      ),
      body: ticketAsync.when(
        loading: () => _Skeleton(),
        error:   (e, _) => _Err(e.toString()),
        data:    (t) => _Body(ticket: t),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.ticket});
  final TicketModel ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ticket.status.isActive;
    final isCalled = ticket.status == TicketStatus.called;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(children: [
        _TicketCard(ticket: ticket)
          .animate().fadeIn(duration: 400.ms).slideY(begin: -.05, curve: Curves.easeOutCubic),

        if (isCalled) ...[
          const SizedBox(height: 16),
          _CalledAlert(counterName: ticket.counter?.name ?? 'Guichet')
            .animate().scale(begin: const Offset(.95,.95)).fadeIn(),
        ],

        const SizedBox(height: 16),
        _BranchCard(ticket: ticket).animate(delay: 100.ms).fadeIn().slideY(begin: .05),

        const SizedBox(height: 24),

        if (isActive) ...[
          SqButton(
            label: 'Voir mon QR Code', icon: Icons.qr_code,
            variant: SqButtonVariant.secondary,
            onPressed: () => context.push(
              '/ticket/${ticket.id}/qr'),
          ).animate(delay: 150.ms).fadeIn(),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              foregroundColor: AppColors.error,
              side: BorderSide(color: AppColors.error.withOpacity(.4)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            onPressed: () => _cancel(context, ref),
            child: const Text('Annuler mon ticket'),
          ).animate(delay: 200.ms).fadeIn(),
        ],

        if (ticket.status == TicketStatus.completed) ...[
          SqButton(
            label: 'Évaluer le service', icon: Icons.star_outline,
            onPressed: () => showModalBottomSheet(
              context: context, isScrollControlled: true,
              backgroundColor: AppColors.bgSurface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
              builder: (_) => FeedbackBottomSheet(ticketId: ticket.id)),
          ).animate().fadeIn(),
        ],

        const SizedBox(height: 32),
      ]),
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Annuler le ticket ?'),
        content: const Text('Votre position sera perdue.',
          style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Non')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true), child: const Text('Oui, annuler')),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await ref.read(cancelTicketNotifierProvider.notifier).cancel(ticket.id);
      if (context.mounted) {
        SqSnackbar.success(context, 'Ticket annulé.');
        context.go(AppRoutes.home);
      }
    }
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.ticket});
  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A2040), Color(0xFF1E2850)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(.25))),
      child: Stack(children: [
        Positioned(top: -20, right: -20,
          child: Container(width: 120, height: 120,
            decoration: BoxDecoration(shape: BoxShape.circle,
              color: AppColors.accent.withOpacity(.08)))),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              TicketStatusBadge(status: ticket.status),
              const Spacer(),
              Text(ticket.service.name,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ]),
            const SizedBox(height: 16),
            Text(ticket.code, style: const TextStyle(
              fontFamily: 'Courier', fontSize: 64, fontWeight: FontWeight.w700,
              color: AppColors.accent, height: 1, letterSpacing: -2)),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: TicketInfoChip(
                label: 'Position',
                value: ticket.position != null ? '${ticket.position}ème' : '—',
                icon: Icons.format_list_numbered)),
              const SizedBox(width: 12),
              Expanded(child: TicketInfoChip(
                label: 'Attente est.',
                value: ticket.estimatedWaitMin != null ? '~${ticket.estimatedWaitMin} min' : '—',
                icon: Icons.schedule_outlined)),
            ]),
            if (ticket.status == TicketStatus.waiting &&
                ticket.position != null &&
                (ticket.queue.waitingCount ?? 0) > 0) ...[
              const SizedBox(height: 16),
              PositionProgressBar(
                position: ticket.position!,
                total: ticket.queue.waitingCount ?? ticket.position!),
            ],
          ]),
        ),
      ]),
    );
  }
}

class _CalledAlert extends StatelessWidget {
  const _CalledAlert({required this.counterName});
  final String counterName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warning.withOpacity(.35))),
      child: Row(children: [
        Container(width: 40, height: 40,
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(.2), borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.campaign_outlined, color: AppColors.warning, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("C'est votre tour !",
            style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.w700, fontSize: 15)),
          Text('Rendez-vous au $counterName',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ])),
      ]),
    );
  }
}

class _BranchCard extends StatelessWidget {
  const _BranchCard({required this.ticket});
  final TicketModel ticket;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgSurface, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Établissement', style: TextStyle(
          color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .5)),
        const SizedBox(height: 8),
        Text(ticket.branch.name, style: const TextStyle(
          color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text(ticket.branch.address,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        Row(children: [
          Container(width: 6, height: 6,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
          const SizedBox(width: 6),
          const Text('Ouvert', style: TextStyle(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          const Text('jusqu\'à 17h00', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
        ]),
      ]),
    );
  }
}

class _Skeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.all(20),
      child: Column(children: [
        _SkelBox(220), SizedBox(height: 16), _SkelBox(100), SizedBox(height: 16), _SkelBox(80),
      ]));
  }
}

class _SkelBox extends StatelessWidget {
  const _SkelBox(this.h);
  final double h;
  @override
  Widget build(BuildContext context) {
    return Container(height: h, width: double.infinity,
      decoration: BoxDecoration(color: AppColors.bgSurface, borderRadius: BorderRadius.circular(16)));
  }
}

class _Err extends StatelessWidget {
  const _Err(this.msg);
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.error_outline, color: AppColors.error, size: 48),
        const SizedBox(height: 16),
        Text(msg, textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textSecondary)),
      ])));
  }
}
