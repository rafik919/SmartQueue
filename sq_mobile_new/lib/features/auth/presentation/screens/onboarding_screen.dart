// lib/features/auth/presentation/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartqueue/core/constants/app_constants.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';

class _Step {
  const _Step(this.icon, this.title, this.subtitle, this.color);
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
}

const _steps = [
  _Step(Icons.queue_outlined,
    'Fini les longues\nfiles d\'attente',
    'Prenez votre ticket depuis votre téléphone, où que vous soyez.',
    AppColors.accent),
  _Step(Icons.notifications_active_outlined,
    'Soyez alerté quand\nvotre tour approche',
    'Recevez une notification push dès que votre numéro est sur le point d\'être appelé.',
    AppColors.success),
  _Step(Icons.qr_code_scanner_outlined,
    'Présentez votre\nQR Code à l\'arrivée',
    'Un simple scan suffit pour valider votre présence au guichet.',
    AppColors.accent2),
];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _ctrl = PageController();
  int _cur = 0;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _next() {
    if (_cur < _steps.length - 1) {
      _ctrl.nextPage(duration: 400.ms, curve: Curves.easeOutCubic);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(AppConstants.onboardingKey, true);
    if (mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_cur];
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(onPressed: _finish, child: const Text('Passer')),
        ),
        Expanded(
          child: PageView.builder(
            controller: _ctrl,
            onPageChanged: (i) => setState(() => _cur = i),
            itemCount: _steps.length,
            itemBuilder: (_, i) => _Page(step: _steps[i]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_steps.length, (i) => AnimatedContainer(
                duration: 250.ms,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _cur ? 24 : 6, height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: i == _cur ? step.color : AppColors.border2),
              )),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity, height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: step.color,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0),
                onPressed: _next,
                child: Text(
                  _cur < _steps.length - 1 ? 'Continuer' : 'Commencer',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
      ])),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.step});
  final _Step step;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 120, height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: step.color.withOpacity(.12),
            border: Border.all(color: step.color.withOpacity(.25), width: 1.5)),
          child: Icon(step.icon, size: 52, color: step.color),
        ).animate().scale(begin: const Offset(.7,.7), duration: 500.ms, curve: Curves.easeOutBack).fadeIn(),
        const SizedBox(height: 48),
        Text(step.title, textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 28,
            fontWeight: FontWeight.w700, height: 1.25, letterSpacing: -.5))
          .animate(delay: 100.ms).fadeIn().slideY(begin: .1, curve: Curves.easeOutCubic),
        const SizedBox(height: 16),
        Text(step.subtitle, textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.6))
          .animate(delay: 200.ms).fadeIn().slideY(begin: .1, curve: Curves.easeOutCubic),
      ]),
    );
  }
}
