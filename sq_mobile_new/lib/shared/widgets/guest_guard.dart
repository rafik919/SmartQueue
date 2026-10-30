// lib/shared/widgets/guest_guard.dart
// Bloque certaines actions pour les invités et affiche un dialog
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/auth/presentation/providers/auth_provider.dart';

/// Vérifie si l'utilisateur est invité — si oui, affiche un dialog
/// Retourne true si l'action peut continuer (utilisateur connecté)
Future<bool> checkGuestAccess(BuildContext context, WidgetRef ref) async {
  final state = ref.read(authStateNotifierProvider).value;
  if (state?.isGuest != true) return true; // Connecté → OK

  await showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.bgSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const _GuestSheet(),
  );
  return false;
}

class _GuestSheet extends StatelessWidget {
  const _GuestSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Handle
        Container(width: 40, height: 4,
          decoration: BoxDecoration(
            color: AppColors.border2,
            borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 24),

        // Icône
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(.12),
            shape: BoxShape.circle),
          child: const Icon(Icons.lock_outline,
            color: AppColors.accent, size: 28)),
        const SizedBox(height: 16),

        const Text('Connexion requise',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),

        const Text(
          'Créez un compte gratuit pour prendre\nun ticket et suivre votre position en file.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14, height: 1.5)),
        const SizedBox(height: 28),

        // Avantages compte
        _Benefit(Icons.confirmation_num_outlined, 'Prendre un ticket à distance'),
        const SizedBox(height: 8),
        _Benefit(Icons.notifications_outlined,   'Recevoir une alerte quand c\'est votre tour'),
        const SizedBox(height: 8),
        _Benefit(Icons.history_outlined,          'Consulter votre historique'),
        const SizedBox(height: 28),

        // CTA
        SizedBox(
          width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push(AppRoutes.register);
            },
            child: const Text('Créer un compte gratuit'))),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity, height: 48,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.push(AppRoutes.login);
            },
            child: const Text('J\'ai déjà un compte'))),
      ]),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: AppColors.success.withOpacity(.12),
          borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: AppColors.success, size: 15)),
      const SizedBox(width: 12),
      Expanded(child: Text(label,
        style: const TextStyle(
          color: AppColors.textPrimary, fontSize: 13.5))),
    ]);
  }
}
