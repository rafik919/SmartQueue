// lib/features/home/presentation/screens/service_select_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/home/presentation/providers/home_provider.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
import 'package:smartqueue/features/ticket/presentation/providers/ticket_provider.dart';
import 'package:smartqueue/shared/widgets/guest_guard.dart';
import 'package:smartqueue/shared/widgets/sq_widgets.dart';

class ServiceSelectScreen extends ConsumerWidget {
  const ServiceSelectScreen({super.key, required this.branchId});
  final String branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(branchDetailProvider(branchId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un service'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop()),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(child: Text(e.toString())),
        data:    (b) => _Body(branch: b),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.branch});
  final BranchDetail branch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = branch.queues.where((q) => q.status == 'ACTIVE').toList();
    if (active.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.no_meeting_room_outlined, size: 48, color: AppColors.textMuted),
          SizedBox(height: 16),
          Text('Aucun service disponible.', textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ])));
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.bgSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border)),
          child: Row(children: [
            const Icon(Icons.business_outlined, color: AppColors.accent, size: 16),
            const SizedBox(width: 8),
            Expanded(child: Text(branch.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13, fontWeight: FontWeight.w600))),
            Container(width: 6, height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: branch.openNow ? AppColors.success : AppColors.error)),
            const SizedBox(width: 6),
            Text(branch.openNow ? 'Ouvert' : 'Fermé',
              style: TextStyle(
                color: branch.openNow ? AppColors.success : AppColors.error,
                fontSize: 11, fontWeight: FontWeight.w500)),
          ]))),

      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Align(alignment: Alignment.centerLeft,
          child: Text('Sélectionnez un service',
            style: Theme.of(context).textTheme.titleMedium))),

      Expanded(child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        itemCount: active.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _Tile(q: active[i], branchId: branch.id)
          .animate(delay: (i * 60).ms).fadeIn().slideY(begin: .05))),
    ]);
  }
}

class _Tile extends ConsumerWidget {
  const _Tile({required this.q, required this.branchId});
  final QueueSummary q;
  final String branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(createTicketNotifierProvider).isLoading;
    return GestureDetector(
      onTap: loading ? null : () => _take(context, ref),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border)),
        child: Row(children: [
          Container(width: 48, height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(.10),
              borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.article_outlined,
              color: AppColors.accent, size: 22)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(q.service.name, style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.people_outline, size: 11, color: AppColors.textMuted),
              const SizedBox(width: 3),
              Text('${q.waitingCount ?? 0} en attente',
                style: const TextStyle(color: AppColors.textMuted, fontSize: 11.5)),
              if (q.avgWaitMin != null) ...[
                const SizedBox(width: 8),
                const Icon(Icons.schedule_outlined, size: 11, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text('~${q.avgWaitMin} min',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11.5)),
              ],
            ]),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.accent, AppColors.accent2],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20)),
            child: loading
              ? const SizedBox(width: 14, height: 14,
                  child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
              : const Text('Prendre',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12, fontWeight: FontWeight.w700))),
        ]),
      ),
    );
  }

  Future<void> _take(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();

    // ── Vérifier mode invité ──────────────────────────────────────────────────
    final canProceed = await checkGuestAccess(context, ref);
    if (!canProceed) return;

    // ── Confirmation ──────────────────────────────────────────────────────────
    final ok = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _ConfirmSheet(q: q));
    if (ok != true || !context.mounted) return;

    final ticket = await ref
        .read(createTicketNotifierProvider.notifier)
        .create(CreateTicketDto(
          queueId: q.id,
          branchId: branchId,
          serviceId: q.service.id));
    if (!context.mounted) return;

    if (ticket != null) {
      HapticFeedback.heavyImpact();
      context.pushReplacement('/ticket/${ticket.id}');
    } else {
      final err = ref.read(createTicketNotifierProvider).error;
      SqSnackbar.error(context, err?.toString() ?? 'Erreur');
    }
  }
}

class _ConfirmSheet extends StatelessWidget {
  const _ConfirmSheet({required this.q});
  final QueueSummary q;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4,
          decoration: BoxDecoration(
            color: AppColors.border2,
            borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 24),
        Container(width: 64, height: 64,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(.12),
            shape: BoxShape.circle),
          child: const Icon(Icons.confirmation_num_outlined,
            color: AppColors.accent, size: 28)),
        const SizedBox(height: 16),
        const Text('Confirmer la prise de ticket',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text('Service : ${q.service.name}',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          '${q.waitingCount ?? 0} en attente'
          '${q.avgWaitMin != null ? " · ~${q.avgWaitMin} min" : ""}',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        const SizedBox(height: 28),
        SizedBox(width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Oui, prendre ce ticket'))),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, height: 48,
          child: TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'))),
      ]),
    );
  }
}
