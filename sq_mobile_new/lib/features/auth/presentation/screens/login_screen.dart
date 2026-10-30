// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/auth/presentation/providers/auth_provider.dart';
import 'package:smartqueue/shared/widgets/demo_banner.dart';
import 'package:smartqueue/shared/widgets/sq_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref.read(authStateNotifierProvider.notifier).login(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text,
    );
    if (!mounted) return;
    final err = ref.read(authStateNotifierProvider).error;
    if (err != null) SqSnackbar.error(context, err.toString());
  }

  Future<void> _continueAsGuest() async {
    await ref.read(authStateNotifierProvider.notifier).continueAsGuest();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authStateNotifierProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                // Logo + titre
                Center(
                  child: Column(children: [
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.accent, AppColors.accent2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(18)),
                      child: const Icon(Icons.queue, color: Colors.white, size: 32)),
                    const SizedBox(height: 20),
                    Text('SmartQueue',
                      style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 6),
                    Text('Connectez-vous à votre compte',
                      style: Theme.of(context).textTheme.bodyMedium),
                  ]).animate().fadeIn(duration: 400.ms).slideY(begin: -.1),
                ),

                const SizedBox(height: 32),
                const DemoModeChip(),

                // Champs
                SqTextField(
                  controller: _emailCtrl,
                  label: 'Email',
                  hint: 'vous@exemple.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email requis';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v))
                      return 'Email invalide';
                    return null;
                  },
                ).animate().fadeIn(delay: 100.ms),

                const SizedBox(height: 14),

                SqTextField(
                  controller: _passCtrl,
                  label: 'Mot de passe',
                  hint: '••••••••',
                  obscureText: _hide,
                  prefixIcon: Icons.lock_outlined,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hide ? Icons.visibility_outlined
                             : Icons.visibility_off_outlined,
                      color: AppColors.textMuted, size: 20),
                    onPressed: () => setState(() => _hide = !_hide)),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Mot de passe requis';
                    if (v.length < 6) return 'Minimum 6 caractères';
                    return null;
                  },
                ).animate().fadeIn(delay: 150.ms),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Mot de passe oublié ?')),
                ).animate().fadeIn(delay: 180.ms),

                const SizedBox(height: 4),

                // Bouton Se connecter
                SqButton(
                  label: 'Se connecter',
                  isLoading: loading,
                  onPressed: loading ? null : _submit,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: .1),

                const SizedBox(height: 16),

                // Divider
                Row(children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('ou',
                      style: Theme.of(context).textTheme.bodyMedium)),
                  const Expanded(child: Divider()),
                ]).animate().fadeIn(delay: 220.ms),

                const SizedBox(height: 16),

                // Bouton Invité
                _GuestButton(
                  onTap: loading ? null : _continueAsGuest,
                ).animate().fadeIn(delay: 240.ms),

                const SizedBox(height: 12),

                // Créer un compte
                OutlinedButton(
                  onPressed: () => context.push(AppRoutes.register),
                  child: const Text('Créer un compte'),
                ).animate().fadeIn(delay: 260.ms),

                const SizedBox(height: 24),

                Center(
                  child: Text(
                    'En continuant, vous acceptez nos Conditions d\'utilisation.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall),
                ).animate().fadeIn(delay: 280.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Bouton invité ─────────────────────────────────────────────────────────────
class _GuestButton extends StatelessWidget {
  const _GuestButton({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.bgSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: AppColors.bgSurface2,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border2)),
              child: const Icon(Icons.person_outline,
                color: AppColors.textSecondary, size: 16)),
            const SizedBox(width: 10),
            const Text('Continuer en tant qu\'invité',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15, fontWeight: FontWeight.w500)),
            const SizedBox(width: 6),
            const Text('— limité',
              style: TextStyle(
                color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
