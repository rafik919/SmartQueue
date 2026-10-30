// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/features/auth/presentation/providers/auth_provider.dart';
import 'package:smartqueue/features/auth/presentation/screens/login_screen.dart';
import 'package:smartqueue/features/auth/presentation/screens/register_screen.dart';
import 'package:smartqueue/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:smartqueue/features/home/presentation/screens/home_screen.dart';
import 'package:smartqueue/features/home/presentation/screens/branch_detail_screen.dart';
import 'package:smartqueue/features/home/presentation/screens/service_select_screen.dart';
import 'package:smartqueue/features/ticket/presentation/screens/active_ticket_screen.dart';
import 'package:smartqueue/features/ticket/presentation/screens/ticket_history_screen.dart';
import 'package:smartqueue/features/ticket/presentation/screens/qr_code_screen.dart';
import 'package:smartqueue/features/profile/presentation/profile_screen.dart';
import 'package:smartqueue/shared/widgets/sq_widgets.dart';

part 'app_router.g.dart';

class AppRoutes {
  AppRoutes._();
  static const onboarding    = '/onboarding';
  static const login         = '/login';
  static const register      = '/register';
  static const home          = '/home';
  static const branchDetail  = '/branch/:branchId';
  static const serviceSelect = '/branch/:branchId/service';
  static const activeTicket  = '/ticket/:ticketId';
  static const ticketQr      = '/ticket/:ticketId/qr';
  static const ticketHistory = '/history';
  static const profile       = '/profile';
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  // Écouter l'état auth — le router se reconstruit quand auth change
  final authAsync = ref.watch(authStateNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    // Refresh le router quand auth change
    refreshListenable: _AuthNotifier(ref),
    redirect: (context, state) {
      final isLoading = authAsync.isLoading;
      if (isLoading) return null; // Attendre

      final isLoggedIn = authAsync.value?.isAuthenticated ?? false;
      final loc = state.matchedLocation;

      final isAuthPage = loc == AppRoutes.login ||
                         loc == AppRoutes.register ||
                         loc == AppRoutes.onboarding;

      // Non connecté et pas sur page auth → login
      if (!isLoggedIn && !isAuthPage) return AppRoutes.login;

      // Connecté et sur page auth → home
      if (isLoggedIn && isAuthPage) return AppRoutes.home;

      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.onboarding, builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: AppRoutes.login,      builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppRoutes.register,   builder: (_, __) => const RegisterScreen()),

      ShellRoute(
        builder: (_, __, child) => MainShell(child: child),
        routes: [
          GoRoute(path: AppRoutes.home,          builder: (_, __) => const HomeScreen()),
          GoRoute(path: AppRoutes.ticketHistory, builder: (_, __) => const TicketHistoryScreen()),
          GoRoute(path: AppRoutes.profile,       builder: (_, __) => const ProfileScreen()),
        ],
      ),

      GoRoute(
        path: AppRoutes.branchDetail,
        builder: (_, s) => BranchDetailScreen(
          branchId: s.pathParameters['branchId']!)),
      GoRoute(
        path: AppRoutes.serviceSelect,
        builder: (_, s) => ServiceSelectScreen(
          branchId: s.pathParameters['branchId']!)),
      GoRoute(
        path: AppRoutes.activeTicket,
        builder: (_, s) => ActiveTicketScreen(
          ticketId: s.pathParameters['ticketId']!)),
      GoRoute(
        path: AppRoutes.ticketQr,
        builder: (_, s) => QrCodeScreen(
          ticketId: s.pathParameters['ticketId']!)),
    ],
    errorBuilder: (_, s) => Scaffold(
      body: Center(child: Text('Page introuvable: ${s.error}'))),
  );
}

// Notifie GoRouter quand l'état auth change
class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier(this._ref) {
    _ref.listen(authStateNotifierProvider, (_, __) {
      notifyListeners();
    });
  }
  final Ref _ref;
}
