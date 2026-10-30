// lib/features/home/presentation/widgets/home_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/home/presentation/providers/home_provider.dart';

class OrgCard extends ConsumerWidget {
  const OrgCard({super.key, required this.org, required this.onTap, this.isFavorite = false});
  final OrganizationCard org;
  final VoidCallback onTap;
  final bool isFavorite;

  static Color _typeColor(String t) => switch (t) {
    'bank'           => AppColors.accent,
    'hospital'       => AppColors.error,
    'administration' => AppColors.success,
    'post'           => AppColors.warning,
    _                => AppColors.accent2,
  };
  static IconData _typeIcon(String t) => switch (t) {
    'bank'           => Icons.account_balance_outlined,
    'hospital'       => Icons.local_hospital_outlined,
    'administration' => Icons.business_outlined,
    'post'           => Icons.local_post_office_outlined,
    _                => Icons.domain_outlined,
  };
  static String _typeLabel(String t) => switch (t) {
    'bank'           => 'Banque',
    'hospital'       => 'Hôpital',
    'administration' => 'Admin.',
    'post'           => 'Poste',
    _                => 'Autre',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = _typeColor(org.type);
    final ti = _typeIcon(org.type);
    final tl = _typeLabel(org.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bgSurface, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: tc.withOpacity(.12), borderRadius: BorderRadius.circular(12),
                border: Border.all(color: tc.withOpacity(.2))),
              child: Icon(ti, color: tc, size: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(org.name, style: const TextStyle(
                color: AppColors.textPrimary, fontSize: 14.5, fontWeight: FontWeight.w600),
                maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Row(children: [
                const Icon(Icons.location_on_outlined, size: 11, color: AppColors.textMuted),
                const SizedBox(width: 3),
                Text(org.city ?? 'Algérie',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11.5)),
              ]),
            ])),
            // Badge type
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tc.withOpacity(.10), borderRadius: BorderRadius.circular(20)),
              child: Text(tl, style: TextStyle(
                color: tc, fontSize: 10, fontWeight: FontWeight.w600))),
            const SizedBox(width: 8),
            // Bouton favori
            GestureDetector(
              onTap: () {
                ref.read(favoriteToggleProvider.notifier)
                    .toggle(org.id, add: !isFavorite);
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFavorite),
                  color: isFavorite ? AppColors.error : AppColors.textMuted,
                  size: 20,
                ),
              ),
            ),
          ]),
          if (org.branches.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            ...org.branches.take(2).map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(children: [
                Container(width: 6, height: 6,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    color: b.openNow ? AppColors.success : AppColors.textMuted)),
                const SizedBox(width: 8),
                Expanded(child: Text(b.name,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  maxLines: 1, overflow: TextOverflow.ellipsis)),
                Text(b.openNow ? 'Ouvert' : 'Fermé',
                  style: TextStyle(
                    color: b.openNow ? AppColors.success : AppColors.textMuted,
                    fontSize: 10.5, fontWeight: FontWeight.w500)),
              ]),
            )),
            if (org.branches.length > 2)
              Text('+${org.branches.length - 2} agences',
                style: const TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w500)),
          ],
        ]),
      ),
    );
  }
}

class OrgTypeChip extends StatelessWidget {
  const OrgTypeChip({super.key, required this.label, required this.icon, required this.selected, required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent.withOpacity(.15) : AppColors.bgSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.accent : AppColors.border, width: selected ? 1.5 : 1)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 14, color: selected ? AppColors.accent : AppColors.textMuted),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            color: selected ? AppColors.accent : AppColors.textSecondary,
            fontSize: 12.5, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
        ]),
      ),
    );
  }
}