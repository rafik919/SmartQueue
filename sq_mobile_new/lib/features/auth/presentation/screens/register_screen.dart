import 'package:smartqueue/shared/widgets/demo_banner.dart';
// lib/features/auth/presentation/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/auth/presentation/providers/auth_provider.dart';
import 'package:smartqueue/shared/widgets/sq_widgets.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _form        = GlobalKey<FormState>();
  final _firstCtrl   = TextEditingController();
  final _lastCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _phoneCtrl   = TextEditingController();
  final _passCtrl    = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _firstCtrl.dispose(); _lastCtrl.dispose(); _emailCtrl.dispose();
    _phoneCtrl.dispose(); _passCtrl.dispose(); _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref.read(authStateNotifierProvider.notifier).register(
      firstName: _firstCtrl.text.trim(), lastName: _lastCtrl.text.trim(),
      email: _emailCtrl.text.trim(), password: _passCtrl.text,
      phone: _phoneCtrl.text.isEmpty ? null : _phoneCtrl.text.trim(),
    );
    if (!mounted) return;
    final err = ref.read(authStateNotifierProvider).error;
    if (err != null) SqSnackbar.error(context, err.toString());
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authStateNotifierProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(key: _form, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vos informations', style: Theme.of(context).textTheme.headlineMedium)
                .animate().fadeIn(),
              const SizedBox(height: 4),
              Text('Remplissez les champs ci-dessous.',
                style: Theme.of(context).textTheme.bodyMedium)
                .animate().fadeIn(delay: 50.ms),
              const SizedBox(height: 28),
              const DemoModeChip(),
              Row(children: [
                Expanded(child: SqTextField(
                  controller: _firstCtrl, label: 'Prénom', hint: 'Sara',
                  textInputAction: TextInputAction.next,
                  validator: (v) => v == null || v.isEmpty ? 'Requis' : null)),
                const SizedBox(width: 12),
                Expanded(child: SqTextField(
                  controller: _lastCtrl, label: 'Nom', hint: 'Benali',
                  textInputAction: TextInputAction.next,
                  validator: (v) => v == null || v.isEmpty ? 'Requis' : null)),
              ]).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 14),
              SqTextField(
                controller: _emailCtrl, label: 'Email', hint: 'vous@exemple.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Requis';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return 'Email invalide';
                  return null;
                },
              ).animate().fadeIn(delay: 150.ms),
              const SizedBox(height: 14),
              SqTextField(
                controller: _phoneCtrl, label: 'Téléphone (optionnel)',
                hint: '+213 555 001 122',
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
                textInputAction: TextInputAction.next,
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 14),
              SqTextField(
                controller: _passCtrl, label: 'Mot de passe', hint: '••••••••',
                obscureText: _hide, prefixIcon: Icons.lock_outlined,
                textInputAction: TextInputAction.next,
                suffixIcon: IconButton(
                  icon: Icon(_hide ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.textMuted, size: 20),
                  onPressed: () => setState(() => _hide = !_hide)),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Requis';
                  if (v.length < 8) return 'Minimum 8 caractères';
                  if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Au moins 1 majuscule';
                  return null;
                },
              ).animate().fadeIn(delay: 250.ms),
              const SizedBox(height: 14),
              SqTextField(
                controller: _confirmCtrl, label: 'Confirmer le mot de passe',
                hint: '••••••••', obscureText: _hide,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                validator: (v) =>
                  v != _passCtrl.text ? 'Les mots de passe ne correspondent pas' : null,
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 28),
              SqButton(
                label: 'Créer mon compte', isLoading: loading,
                onPressed: loading ? null : _submit,
              ).animate().fadeIn(delay: 350.ms).slideY(begin: .1),
              const SizedBox(height: 20),
              Center(child: Text(
                'En créant un compte, vous acceptez nos Conditions d\'utilisation.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              )).animate().fadeIn(delay: 400.ms),
            ],
          )),
        ),
      ),
    );
  }
}
