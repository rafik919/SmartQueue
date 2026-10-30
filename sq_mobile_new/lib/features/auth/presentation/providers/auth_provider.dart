// lib/features/auth/presentation/providers/auth_provider.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/mock/mock_data.dart';
import 'package:smartqueue/core/mock/mock_providers.dart';
import 'package:smartqueue/features/auth/data/auth_models.dart';
import 'package:smartqueue/features/auth/data/auth_repository.dart';

part 'auth_provider.freezed.dart';
part 'auth_provider.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    UserModel? user,
    @Default(false) bool isGuest,
  }) = _AuthState;
  const AuthState._();
  bool get isAuthenticated => user != null || isGuest;
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  Future<AuthState> build() async {
    if (kMockMode) return const AuthState();
    final repo = ref.read(authRepositoryProvider);
    if (!await repo.isAuthenticated()) return const AuthState();
    final user = await repo.getCurrentUser();
    return AuthState(user: user);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    if (kMockMode) {
      await Future.delayed(const Duration(milliseconds: 800));
      final first = email.split('@').first;
      final name  = first.isEmpty ? first : first[0].toUpperCase() + first.substring(1);
      state = AsyncValue.data(AuthState(
        user: mockUser.copyWith(email: email, firstName: name),
      ));
      return;
    }
    state = await AsyncValue.guard(() async {
      final auth = await ref.read(authRepositoryProvider)
          .login(email: email, password: password);
      return AuthState(user: auth.user);
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    state = const AsyncValue.loading();
    if (kMockMode) {
      await Future.delayed(const Duration(milliseconds: 1000));
      state = AsyncValue.data(AuthState(
        user: mockUser.copyWith(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        ),
      ));
      return;
    }
    state = await AsyncValue.guard(() async {
      final auth = await ref.read(authRepositoryProvider).register(
        email: email, password: password,
        firstName: firstName, lastName: lastName, phone: phone,
      );
      return AuthState(user: auth.user);
    });
  }

  Future<void> continueAsGuest() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 400));
    state = const AsyncValue.data(AuthState(isGuest: true));
  }

  Future<void> logout() async {
    if (!kMockMode) await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(AuthState());
  }
}
