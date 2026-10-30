// lib/shared/widgets/demo_banner.dart
import 'package:flutter/material.dart';
import 'package:smartqueue/core/mock/mock_providers.dart';
import 'package:smartqueue/core/theme/app_theme.dart';

class DemoBanner extends StatelessWidget {
  const DemoBanner({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kMockMode) return child;

    // Directionality requis par Banner
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: 'DÉMO',
        location: BannerLocation.topEnd,
        color: AppColors.warning,
        textStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}

class DemoModeChip extends StatelessWidget {
  const DemoModeChip({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kMockMode) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withOpacity(0.35)),
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.science_outlined, color: AppColors.warning, size: 16),
          const SizedBox(width: 8),
          const Text('MODE DÉMO ACTIVÉ',
            style: TextStyle(
              color: AppColors.warning,
              fontSize: 12, fontWeight: FontWeight.w700,
              letterSpacing: 0.5)),
        ]),
        const SizedBox(height: 6),
        const Text(
          'Utilise n\'importe quel email et mot de passe.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.bgSurface2,
            borderRadius: BorderRadius.circular(8)),
          child: const Text('demo@test.com  /  123456',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontFamily: 'monospace')),
        ),
      ]),
    );
  }
}
