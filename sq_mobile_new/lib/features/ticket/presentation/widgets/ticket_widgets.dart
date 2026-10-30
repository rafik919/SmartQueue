// lib/features/ticket/presentation/widgets/ticket_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/ticket/data/ticket_models.dart';
import 'package:smartqueue/features/ticket/presentation/providers/ticket_provider.dart';

// ── TicketStatusBadge ─────────────────────────────────────────────────────────
class TicketStatusBadge extends StatelessWidget {
  const TicketStatusBadge({super.key, required this.status});
  final TicketStatus status;

  Color get _color => switch (status) {
    TicketStatus.waiting     => AppColors.accent,
    TicketStatus.called      => AppColors.warning,
    TicketStatus.inService   => AppColors.success,
    TicketStatus.completed   => AppColors.textMuted,
    TicketStatus.cancelled   => AppColors.error,
    TicketStatus.missed      => AppColors.warning,
    TicketStatus.transferred => AppColors.info,
    TicketStatus.expired     => AppColors.textMuted,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(.35))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _color,
            boxShadow: [BoxShadow(color: _color.withOpacity(.5), blurRadius: 4)])),
        const SizedBox(width: 6),
        Text(status.label, style: TextStyle(
          color: _color, fontSize: 11.5, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

// ── PositionProgressBar ───────────────────────────────────────────────────────
class PositionProgressBar extends StatelessWidget {
  const PositionProgressBar({super.key, required this.position, required this.total});
  final int position;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? ((total - position + 1) / total).clamp(0.0, 1.0) : 0.0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Text('Position dans la file',
          style: TextStyle(color: AppColors.textMuted, fontSize: 10, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text('$position / $total',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: progress, minHeight: 4,
          backgroundColor: AppColors.border,
          valueColor: const AlwaysStoppedAnimation(AppColors.accent)),
      ),
    ]);
  }
}

// ── TicketInfoChip ────────────────────────────────────────────────────────────
class TicketInfoChip extends StatelessWidget {
  const TicketInfoChip({super.key, required this.label, required this.value, required this.icon});
  final String label, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgSurface2, borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border)),
      child: Row(children: [
        Icon(icon, color: AppColors.textMuted, size: 14),
        const SizedBox(width: 6),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(
            color: AppColors.textMuted, fontSize: 9.5, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(
            color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
        ]),
      ]),
    );
  }
}

// ── FeedbackBottomSheet ───────────────────────────────────────────────────────
class FeedbackBottomSheet extends ConsumerStatefulWidget {
  const FeedbackBottomSheet({super.key, required this.ticketId});
  final String ticketId;
  @override
  ConsumerState<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends ConsumerState<FeedbackBottomSheet> {
  int _rating = 0;
  final _commentCtrl = TextEditingController();
  final _tags = <String>{};
  static const _allTags = ['Service rapide','Agent aimable','Longue attente','Salle propre','À améliorer'];

  @override
  void dispose() { _commentCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(feedbackNotifierProvider).isLoading;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.border2, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          const Text('Évaluez votre expérience',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Votre avis nous aide à améliorer le service.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 24),
          Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) => GestureDetector(
              onTap: () => setState(() => _rating = i + 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  i < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                  size: 40, color: i < _rating ? AppColors.warning : AppColors.textMuted)),
            )),
          )),
          const SizedBox(height: 20),
          Wrap(spacing: 8, runSpacing: 8, children: _allTags.map((t) {
            final sel = _tags.contains(t);
            return GestureDetector(
              onTap: () => setState(() => sel ? _tags.remove(t) : _tags.add(t)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: sel ? AppColors.accent.withOpacity(.15) : AppColors.bgSurface2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: sel ? AppColors.accent : AppColors.border)),
                child: Text(t, style: TextStyle(
                  color: sel ? AppColors.accent : AppColors.textSecondary,
                  fontSize: 12, fontWeight: FontWeight.w500)),
              ),
            );
          }).toList()),
          const SizedBox(height: 16),
          TextField(
            controller: _commentCtrl, maxLines: 3,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Commentaire optionnel...',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              filled: true, fillColor: AppColors.bgSurface2,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.accent))),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _rating == 0 || loading ? null : _submit,
            child: loading
              ? const SizedBox(width: 20, height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('Envoyer mon évaluation'),
          ),
        ]),
      ),
    );
  }

  Future<void> _submit() async {
    await ref.read(feedbackNotifierProvider.notifier).submit(
      ticketId: widget.ticketId, rating: _rating,
      comment: _commentCtrl.text.isEmpty ? null : _commentCtrl.text,
      tags: _tags.toList());
    if (mounted) Navigator.pop(context);
  }
}
