// lib/features/home/presentation/screens/branch_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/home/presentation/providers/home_provider.dart';

class BranchDetailScreen extends ConsumerWidget {
  const BranchDetailScreen({super.key, required this.branchId});
  final String branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(branchDetailProvider(branchId));
    return Scaffold(
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(child: Text(e.toString())),
        data:    (b) => _Content(branch: b),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.branch});
  final BranchDetail branch;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 140, pinned: true,
        backgroundColor: AppColors.bgSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop()),
        flexibleSpace: FlexibleSpaceBar(
          title: Text(branch.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          titlePadding: const EdgeInsets.fromLTRB(52, 0, 16, 14),
          background: Container(
            decoration: const BoxDecoration(gradient: LinearGradient(
              colors: [AppColors.bgSurface, AppColors.bgSurface2],
              begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Center(child: Icon(Icons.business_outlined,
              size: 48, color: AppColors.accent.withOpacity(.3)))),
        ),
      ),
      SliverToBoxAdapter(child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: _InfoCard(branch: branch)).animate().fadeIn()),
      SliverToBoxAdapter(child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
        child: Row(children: [
          Text('Services disponibles', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          Text('${branch.queues.length} files',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        ]))),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: branch.queues.length,
          itemBuilder: (_, i) => _QueueCard(q: branch.queues[i], branchId: branch.id)
            .animate(delay: (i * 50).ms).fadeIn().slideX(begin: .03))),
      const SliverToBoxAdapter(child: SizedBox(height: 32)),
    ]);
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.branch});
  final BranchDetail branch;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgSurface, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border)),
      child: Column(children: [
        _Row(Icons.location_on_outlined, branch.address),
        if (branch.phone != null) ...[const SizedBox(height: 8), _Row(Icons.phone_outlined, branch.phone!)],
        const SizedBox(height: 8),
        _Row(Icons.access_time_outlined,
          branch.openNow ? 'Ouvert${branch.openUntil != null ? " jusqu\'à ${branch.openUntil}" : ""}' : 'Fermé actuellement',
          color: branch.openNow ? AppColors.success : AppColors.error),
      ]),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.text, {this.color});
  final IconData icon; final String text; final Color? color;
  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return Row(children: [
      Icon(icon, size: 14, color: c), const SizedBox(width: 8),
      Expanded(child: Text(text, style: TextStyle(color: c, fontSize: 13))),
    ]);
  }
}

class _QueueCard extends StatelessWidget {
  const _QueueCard({required this.q, required this.branchId});
  final QueueSummary q;
  final String branchId;

  @override
  Widget build(BuildContext context) {
    final isActive = q.status == 'ACTIVE';
    final isPaused = q.status == 'PAUSED';
    return GestureDetector(
      onTap: isActive ? () => context.push('/branch/$branchId/service') : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bgSurface, borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border)),
        child: Row(children: [
          Container(width: 42, height: 42,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(.10), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.miscellaneous_services_outlined, color: AppColors.accent, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(q.service.name, style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text('${q.waitingCount ?? 0} en attente${q.avgWaitMin != null ? " · ~${q.avgWaitMin} min" : ""}',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: (isActive ? AppColors.success : isPaused ? AppColors.warning : AppColors.error).withOpacity(.12),
                borderRadius: BorderRadius.circular(20)),
              child: Text(isActive ? 'Ouvert' : isPaused ? 'Pause' : 'Fermé',
                style: TextStyle(
                  color: isActive ? AppColors.success : isPaused ? AppColors.warning : AppColors.error,
                  fontSize: 10, fontWeight: FontWeight.w600))),
            if (isActive) ...[const SizedBox(height: 6),
              const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 16)],
          ]),
        ]),
      ),
    );
  }
}
