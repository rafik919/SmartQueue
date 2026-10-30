// lib/features/profile/presentation/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/api/api_client.dart';
import 'package:smartqueue/core/constants/app_constants.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/auth/data/auth_repository.dart';
import 'package:smartqueue/features/auth/presentation/providers/auth_provider.dart';
import 'package:smartqueue/features/home/presentation/providers/home_provider.dart';
import 'package:smartqueue/shared/widgets/sq_widgets.dart';

// ── Language provider ─────────────────────────────────────────────────────────
final languageProvider = StateProvider<String>((ref) => 'fr');

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider).value;
    final isGuest   = authState?.isGuest ?? false;
    final user      = authState?.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Mon profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [

          // Header
          if (isGuest)
            _GuestHeader().animate().fadeIn().slideY(begin: -.05)
          else if (user != null)
            _UserHeader(
              name: '${user.firstName} ${user.lastName}',
              email: user.email,
              phone: user.phone,
            ).animate().fadeIn().slideY(begin: -.05),

          const SizedBox(height: 24),

          if (isGuest) ...[
            _ConnectBanner().animate(delay: 50.ms).fadeIn(),
            const SizedBox(height: 16),
          ],

          if (!isGuest) ...[
            // ── Compte ────────────────────────────────────────────────────
            _Section(title: 'Compte', items: [
              _Item(
                Icons.person_outline, 'Modifier mon profil',
                onTap: () => _showEditProfile(context, ref, user!.firstName, user.lastName, user.phone),
              ),
              _Item(
                Icons.lock_outline, 'Changer le mot de passe',
                onTap: () => _showChangePassword(context, ref),
              ),
              _Item(
                Icons.language_outlined, 'Langue',
                trailing: _LanguageBadge(),
                onTap: () => _showLanguagePicker(context, ref),
              ),
            ]).animate(delay: 100.ms).fadeIn(),
            const SizedBox(height: 16),

            // ── Historique ────────────────────────────────────────────────
            _Section(title: 'Mes données', items: [
              _Item(
                Icons.confirmation_num_outlined, 'Mes tickets',
                onTap: () => context.go(AppRoutes.ticketHistory),
              ),
              _Item(
                Icons.favorite_outline, 'Établissements favoris',
                onTap: () => _showFavorites(context, ref),
              ),
            ]).animate(delay: 150.ms).fadeIn(),
            const SizedBox(height: 16),
          ],

          // ── À propos ──────────────────────────────────────────────────
          _Section(title: 'À propos', items: [
            _Item(
              Icons.info_outline, 'Version de l\'application',
              trailing: const Text('1.0.0',
                style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              onTap: null,
            ),
          ]).animate(delay: 200.ms).fadeIn(),

          const SizedBox(height: 24),

          // ── Déconnexion ───────────────────────────────────────────────
          SizedBox(
            width: double.infinity, height: 50,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error.withOpacity(.4)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              icon: const Icon(Icons.logout_outlined, size: 18),
              label: Text(isGuest ? 'Quitter le mode invité' : 'Se déconnecter'),
              onPressed: () => _logout(context, ref),
            )).animate(delay: 250.ms).fadeIn(),

          const SizedBox(height: 32),
        ]),
      ),
    );
  }

  // ── Modifier profil ────────────────────────────────────────────────────────
  void _showEditProfile(BuildContext context, WidgetRef ref,
      String firstName, String lastName, String? phone) {
    final firstCtrl = TextEditingController(text: firstName);
    final lastCtrl  = TextEditingController(text: lastName);
    final phoneCtrl = TextEditingController(text: phone ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 20, 24,
          MediaQuery.of(ctx).viewInsets.bottom + 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.border2,
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          const Text('Modifier mon profil',
            style: TextStyle(color: AppColors.textPrimary,
              fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          SqTextField(label: 'Prénom', controller: firstCtrl),
          const SizedBox(height: 12),
          SqTextField(label: 'Nom', controller: lastCtrl),
          const SizedBox(height: 12),
          SqTextField(label: 'Téléphone', controller: phoneCtrl,
            keyboardType: TextInputType.phone),
          const SizedBox(height: 20),
          SqButton(
            label: 'Enregistrer',
            onPressed: () async {
              try {
                final dio = ref.read(dioProvider);
                await dio.patch('/users/me', data: {
                  'firstName': firstCtrl.text.trim(),
                  'lastName':  lastCtrl.text.trim(),
                  if (phoneCtrl.text.trim().isNotEmpty)
                    'phone': phoneCtrl.text.trim(),
                });
                // Refresh auth state
                await ref.read(authStateNotifierProvider.notifier).build();
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  SqSnackbar.success(context, 'Profil mis à jour !');
                }
              } catch (e) {
                if (ctx.mounted)
                  SqSnackbar.error(context, 'Erreur lors de la mise à jour');
              }
            },
          ),
        ]),
      ),
    );
  }

  // ── Changer mot de passe ──────────────────────────────────────────────────
  void _showChangePassword(BuildContext context, WidgetRef ref) {
    final currentCtrl = TextEditingController();
    final newCtrl     = TextEditingController();
    final confirmCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 20, 24,
          MediaQuery.of(ctx).viewInsets.bottom + 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.border2,
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          const Text('Changer le mot de passe',
            style: TextStyle(color: AppColors.textPrimary,
              fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          SqTextField(label: 'Mot de passe actuel', controller: currentCtrl,
            obscureText: true),
          const SizedBox(height: 12),
          SqTextField(label: 'Nouveau mot de passe', controller: newCtrl,
            obscureText: true),
          const SizedBox(height: 12),
          SqTextField(label: 'Confirmer le nouveau', controller: confirmCtrl,
            obscureText: true),
          const SizedBox(height: 20),
          SqButton(
            label: 'Modifier',
            onPressed: () async {
              if (newCtrl.text != confirmCtrl.text) {
                SqSnackbar.error(context, 'Les mots de passe ne correspondent pas');
                return;
              }
              if (newCtrl.text.length < 8) {
                SqSnackbar.error(context, 'Minimum 8 caractères');
                return;
              }
              try {
                final dio = ref.read(dioProvider);
                await dio.patch('/auth/change-password', data: {
                  'currentPassword': currentCtrl.text,
                  'newPassword':     newCtrl.text,
                });
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                  SqSnackbar.success(context, 'Mot de passe modifié !');
                }
              } catch (e) {
                if (ctx.mounted)
                  SqSnackbar.error(context, 'Mot de passe actuel incorrect');
              }
            },
          ),
        ]),
      ),
    );
  }

  // ── Langue ────────────────────────────────────────────────────────────────
  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final langs = [
      ('fr', 'Français',  '🇫🇷'),
      ('ar', 'العربية',   '🇩🇿'),
      ('en', 'English',   '🇬🇧'),
    ];
    final current = ref.read(languageProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.border2,
              borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          const Text('Choisir la langue',
            style: TextStyle(color: AppColors.textPrimary,
              fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...langs.map((l) {
            final selected = current == l.$1;
            return GestureDetector(
              onTap: () {
                ref.read(languageProvider.notifier).state = l.$1;
                Navigator.pop(ctx);
                SqSnackbar.success(context, 'Langue changée : ${l.$2}');
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: selected ? AppColors.accent.withOpacity(.1) : AppColors.bgSurface2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected ? AppColors.accent : AppColors.border,
                    width: selected ? 1.5 : 1)),
                child: Row(children: [
                  Text(l.$3, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Text(l.$2, style: TextStyle(
                    color: selected ? AppColors.accent : AppColors.textPrimary,
                    fontSize: 15, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
                  const Spacer(),
                  if (selected)
                    const Icon(Icons.check_circle, color: AppColors.accent, size: 18),
                ]),
              ),
            );
          }),
        ]),
      ),
    );
  }

  // ── Favoris ───────────────────────────────────────────────────────────────
  void _showFavorites(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: .6,
        maxChildSize: .9,
        minChildSize: .4,
        expand: false,
        builder: (_, scrollCtrl) => Consumer(
          builder: (_, ref, __) {
            final favAsync = ref.watch(favoritesProvider);
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(children: [
                Container(width: 40, height: 4,
                  decoration: BoxDecoration(color: AppColors.border2,
                    borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 20),
                const Text('Établissements favoris',
                  style: TextStyle(color: AppColors.textPrimary,
                    fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Expanded(child: favAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text(e.toString(),
                      style: const TextStyle(color: AppColors.textSecondary))),
                  data: (favs) => favs.isEmpty
                    ? const Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite_border, size: 40, color: AppColors.textMuted),
                          SizedBox(height: 12),
                          Text('Aucun favori', style: TextStyle(color: AppColors.textSecondary)),
                        ]))
                    : ListView.separated(
                        controller: scrollCtrl,
                        itemCount: favs.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (_, i) {
                          final org = favs[i];
                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.bgSurface2,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border)),
                            child: Row(children: [
                              Container(
                                width: 40, height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.business_outlined,
                                  color: AppColors.accent, size: 18)),
                              const SizedBox(width: 12),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(org.name, style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14, fontWeight: FontWeight.w600),
                                    maxLines: 1, overflow: TextOverflow.ellipsis),
                                  Text(org.city ?? '', style: const TextStyle(
                                    color: AppColors.textMuted, fontSize: 12)),
                                ])),
                              IconButton(
                                icon: const Icon(Icons.favorite,
                                  color: AppColors.error, size: 20),
                                onPressed: () {
                                  ref.read(favoriteToggleProvider.notifier)
                                      .toggle(org.id, add: false);
                                },
                              ),
                            ]),
                          );
                        }),
                )),
              ]),
            );
          },
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authStateNotifierProvider.notifier).logout();
    if (context.mounted) context.go(AppRoutes.login);
  }
}

// ── Guest header ──────────────────────────────────────────────────────────────
class _GuestHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgSurface, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border)),
      child: Row(children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            color: AppColors.bgSurface2, shape: BoxShape.circle,
            border: Border.all(color: AppColors.border2)),
          child: const Icon(Icons.person_outline,
            color: AppColors.textMuted, size: 28)),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Mode Invité',
            style: TextStyle(color: AppColors.textPrimary,
              fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.warning.withOpacity(.3))),
            child: const Text('Fonctionnalités limitées',
              style: TextStyle(color: AppColors.warning,
                fontSize: 10, fontWeight: FontWeight.w600))),
        ]),
      ]),
    );
  }
}

// ── Connect banner ────────────────────────────────────────────────────────────
class _ConnectBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accent.withOpacity(.15), AppColors.accent2.withOpacity(.10)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withOpacity(.25))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.star_outline, color: AppColors.accent, size: 18),
          SizedBox(width: 8),
          Text('Débloquer toutes les fonctionnalités',
            style: TextStyle(color: AppColors.accent,
              fontSize: 14, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 8),
        const Text(
          'Créez un compte gratuit pour prendre des tickets, recevoir des notifications et accéder à votre historique.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5, height: 1.4)),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: SizedBox(height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 13)),
              onPressed: () => context.push(AppRoutes.register),
              child: const Text('Créer un compte')))),
          const SizedBox(width: 10),
          Expanded(child: SizedBox(height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(textStyle: const TextStyle(fontSize: 13)),
              onPressed: () => context.push(AppRoutes.login),
              child: const Text('Se connecter')))),
        ]),
      ]),
    );
  }
}

// ── User header ───────────────────────────────────────────────────────────────
class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.name, required this.email, this.phone});
  final String name, email;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().split(' ').take(2)
      .map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgSurface, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border)),
      child: Row(children: [
        Container(
          width: 64, height: 64,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.accent, AppColors.accent2],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            shape: BoxShape.circle),
          child: Center(child: Text(initials,
            style: const TextStyle(color: Colors.white,
              fontSize: 22, fontWeight: FontWeight.w700)))),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(color: AppColors.textPrimary,
            fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(email, style: const TextStyle(
            color: AppColors.textSecondary, fontSize: 13)),
          if (phone != null) ...[
            const SizedBox(height: 2),
            Text(phone!, style: const TextStyle(
              color: AppColors.textMuted, fontSize: 12)),
          ],
        ])),
      ]),
    );
  }
}

// ── Language badge ────────────────────────────────────────────────────────────
class _LanguageBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    final label = switch (lang) {
      'ar' => 'العربية',
      'en' => 'English',
      _    => 'Français',
    };
    return Text(label,
      style: const TextStyle(color: AppColors.textMuted, fontSize: 13));
  }
}

// ── Section ───────────────────────────────────────────────────────────────────
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});
  final String title;
  final List<_Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(title.toUpperCase(),
          style: const TextStyle(color: AppColors.textMuted, fontSize: 10.5,
            fontWeight: FontWeight.w700, letterSpacing: .8))),
      Container(
        decoration: BoxDecoration(
          color: AppColors.bgSurface, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border)),
        child: Column(children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(children: [
            e.value,
            if (!isLast) const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 1)),
          ]);
        }).toList())),
    ]);
  }
}

// ── Item ──────────────────────────────────────────────────────────────────────
class _Item extends StatelessWidget {
  const _Item(this.icon, this.label, {this.trailing, required this.onTap});
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(child: Text(label,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14))),
          trailing ?? (onTap != null
            ? const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted)
            : const SizedBox()),
        ])),
    );
  }
}