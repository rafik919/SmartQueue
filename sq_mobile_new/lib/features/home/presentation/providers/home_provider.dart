// lib/features/home/presentation/providers/home_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartqueue/core/mock/mock_providers.dart';
import 'package:smartqueue/features/home/data/home_models.dart';
import 'package:smartqueue/features/home/data/home_repository.dart';

part 'home_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  AsyncValue<List<OrganizationCard>> build() => const AsyncValue.data([]);

  Future<void> search({String? query, String? city, String? type}) async {
    state = const AsyncValue.loading();
    if (kMockMode) {
      state = AsyncValue.data(await ref.read(
          mockOrganizationSearchProvider(
            query: query, type: type, city: city,
          ).future));
      return;
    }
    state = await AsyncValue.guard(() =>
        ref.read(homeRepositoryProvider).searchOrganizations(
            query: query, city: city, type: type));
  }

  void reset() => state = const AsyncValue.data([]);
}

@riverpod
Future<List<OrganizationCard>> favorites(FavoritesRef ref) {
  if (kMockMode) return ref.watch(mockFavoritesDataProvider.future);
  return ref.watch(homeRepositoryProvider).getFavorites();
}

@riverpod
Future<BranchDetail> branchDetail(BranchDetailRef ref, String branchId) {
  if (kMockMode) {
    return ref.watch(mockBranchDataProvider(branchId).future);
  }
  return ref.watch(homeRepositoryProvider).getBranchDetail(branchId);
}

@riverpod
class FavoriteToggle extends _$FavoriteToggle {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> toggle(String orgId, {required bool add}) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    state = const AsyncValue.data(null);
    if (!kMockMode) {
      ref.read(homeRepositoryProvider).toggleFavorite(orgId, add: add);
    }
    ref.invalidate(favoritesProvider);
  }
}
