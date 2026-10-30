// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesHash() => r'8ba29504d34fe0a0559c260446b019b383da9bce';

/// See also [favorites].
@ProviderFor(favorites)
final favoritesProvider =
    AutoDisposeFutureProvider<List<OrganizationCard>>.internal(
  favorites,
  name: r'favoritesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favoritesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoritesRef = AutoDisposeFutureProviderRef<List<OrganizationCard>>;
String _$branchDetailHash() => r'2df927c7670f346a83eebdb88644fb6fece489f1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [branchDetail].
@ProviderFor(branchDetail)
const branchDetailProvider = BranchDetailFamily();

/// See also [branchDetail].
class BranchDetailFamily extends Family<AsyncValue<BranchDetail>> {
  /// See also [branchDetail].
  const BranchDetailFamily();

  /// See also [branchDetail].
  BranchDetailProvider call(
    String branchId,
  ) {
    return BranchDetailProvider(
      branchId,
    );
  }

  @override
  BranchDetailProvider getProviderOverride(
    covariant BranchDetailProvider provider,
  ) {
    return call(
      provider.branchId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'branchDetailProvider';
}

/// See also [branchDetail].
class BranchDetailProvider extends AutoDisposeFutureProvider<BranchDetail> {
  /// See also [branchDetail].
  BranchDetailProvider(
    String branchId,
  ) : this._internal(
          (ref) => branchDetail(
            ref as BranchDetailRef,
            branchId,
          ),
          from: branchDetailProvider,
          name: r'branchDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$branchDetailHash,
          dependencies: BranchDetailFamily._dependencies,
          allTransitiveDependencies:
              BranchDetailFamily._allTransitiveDependencies,
          branchId: branchId,
        );

  BranchDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.branchId,
  }) : super.internal();

  final String branchId;

  @override
  Override overrideWith(
    FutureOr<BranchDetail> Function(BranchDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BranchDetailProvider._internal(
        (ref) => create(ref as BranchDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        branchId: branchId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BranchDetail> createElement() {
    return _BranchDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BranchDetailProvider && other.branchId == branchId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, branchId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BranchDetailRef on AutoDisposeFutureProviderRef<BranchDetail> {
  /// The parameter `branchId` of this provider.
  String get branchId;
}

class _BranchDetailProviderElement
    extends AutoDisposeFutureProviderElement<BranchDetail>
    with BranchDetailRef {
  _BranchDetailProviderElement(super.provider);

  @override
  String get branchId => (origin as BranchDetailProvider).branchId;
}

String _$searchNotifierHash() => r'954d194e213bda6452ffa0ae3e34183973d77ef5';

/// See also [SearchNotifier].
@ProviderFor(SearchNotifier)
final searchNotifierProvider = AutoDisposeNotifierProvider<SearchNotifier,
    AsyncValue<List<OrganizationCard>>>.internal(
  SearchNotifier.new,
  name: r'searchNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchNotifier
    = AutoDisposeNotifier<AsyncValue<List<OrganizationCard>>>;
String _$favoriteToggleHash() => r'3bd95ed006b01b3a339fa61f898bab6559eb7324';

/// See also [FavoriteToggle].
@ProviderFor(FavoriteToggle)
final favoriteToggleProvider =
    AutoDisposeNotifierProvider<FavoriteToggle, AsyncValue<void>>.internal(
  FavoriteToggle.new,
  name: r'favoriteToggleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteToggleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoriteToggle = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
