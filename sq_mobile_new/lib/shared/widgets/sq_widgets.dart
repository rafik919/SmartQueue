// lib/shared/widgets/sq_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';

// ── SqTextField ───────────────────────────────────────────────────────────────
class SqTextField extends StatelessWidget {
  const SqTextField({
    super.key, required this.controller, required this.label,
    this.hint, this.prefixIcon, this.suffixIcon, this.obscureText = false,
    this.keyboardType, this.textInputAction, this.onFieldSubmitted,
    this.validator, this.enabled = true, this.maxLines = 1,
  });
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool enabled;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(
        color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller, obscureText: obscureText,
        keyboardType: keyboardType, textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted, validator: validator,
        enabled: enabled, maxLines: obscureText ? 1 : maxLines,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14.5),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.textMuted, size: 18) : null,
          suffixIcon: suffixIcon,
        ),
      ),
    ]);
  }
}

// ── SqButton ──────────────────────────────────────────────────────────────────
enum SqButtonVariant { primary, secondary, danger }

class SqButton extends StatelessWidget {
  const SqButton({
    super.key, required this.label, this.onPressed,
    this.isLoading = false, this.icon, this.variant = SqButtonVariant.primary,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final SqButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (variant) {
      SqButtonVariant.primary   => (AppColors.accent, Colors.white, null),
      SqButtonVariant.secondary => (AppColors.bgSurface2, AppColors.textPrimary, AppColors.border2),
      SqButtonVariant.danger    => (AppColors.error.withOpacity(.12), AppColors.error, AppColors.error.withOpacity(.3)),
    };
    return SizedBox(
      width: double.infinity, height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg, foregroundColor: fg, elevation: 0,
          side: border != null ? BorderSide(color: border) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(width: 20, height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: fg))
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
                Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: fg)),
              ]),
      ),
    );
  }
}

// ── SqSnackbar ────────────────────────────────────────────────────────────────
class SqSnackbar {
  static void success(BuildContext c, String msg) => _show(c, msg, AppColors.success, Icons.check_circle_outline);
  static void error(BuildContext c, String msg)   => _show(c, msg, AppColors.error,   Icons.error_outline);
  static void info(BuildContext c, String msg)    => _show(c, msg, AppColors.accent,  Icons.info_outline);

  static void _show(BuildContext c, String msg, Color color, IconData icon) {
    ScaffoldMessenger.of(c)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(children: [
          Icon(icon, color: color, size: 18), const SizedBox(width: 10),
          Expanded(child: Text(msg,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5))),
        ]),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(.3))),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        duration: const Duration(seconds: 3),
      ));
  }
}

// ── MainShell ─────────────────────────────────────────────────────────────────
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = GoRouterState.of(context).matchedLocation;
    final idx = switch (loc) {
      _ when loc.startsWith(AppRoutes.home)         => 0,
      _ when loc.startsWith(AppRoutes.ticketHistory)=> 1,
      _ when loc.startsWith(AppRoutes.profile)      => 2,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.bgSurface,
          border: Border(top: BorderSide(color: AppColors.border))),
        child: BottomNavigationBar(
          currentIndex: idx,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          onTap: (i) => context.go([AppRoutes.home, AppRoutes.ticketHistory, AppRoutes.profile][i]),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),            activeIcon: Icon(Icons.home),            label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined), activeIcon: Icon(Icons.confirmation_num), label: 'Tickets'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline),            activeIcon: Icon(Icons.person),           label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
