// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mockOrganizationSearchHash() =>
    r'd9e5d54a1e63fb26391cd2a52898bd1b19b4e5c3';

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

/// See also [mockOrganizationSearch].
@ProviderFor(mockOrganizationSearch)
const mockOrganizationSearchProvider = MockOrganizationSearchFamily();

/// See also [mockOrganizationSearch].
class MockOrganizationSearchFamily
    extends Family<AsyncValue<List<OrganizationCard>>> {
  /// See also [mockOrganizationSearch].
  const MockOrganizationSearchFamily();

  /// See also [mockOrganizationSearch].
  MockOrganizationSearchProvider call({
    String? query,
    String? type,
    String? city,
  }) {
    return MockOrganizationSearchProvider(
      query: query,
      type: type,
      city: city,
    );
  }

  @override
  MockOrganizationSearchProvider getProviderOverride(
    covariant MockOrganizationSearchProvider provider,
  ) {
    return call(
      query: provider.query,
      type: provider.type,
      city: provider.city,
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
  String? get name => r'mockOrganizationSearchProvider';
}

/// See also [mockOrganizationSearch].
class MockOrganizationSearchProvider
    extends AutoDisposeFutureProvider<List<OrganizationCard>> {
  /// See also [mockOrganizationSearch].
  MockOrganizationSearchProvider({
    String? query,
    String? type,
    String? city,
  }) : this._internal(
          (ref) => mockOrganizationSearch(
            ref as MockOrganizationSearchRef,
            query: query,
            type: type,
            city: city,
          ),
          from: mockOrganizationSearchProvider,
          name: r'mockOrganizationSearchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mockOrganizationSearchHash,
          dependencies: MockOrganizationSearchFamily._dependencies,
          allTransitiveDependencies:
              MockOrganizationSearchFamily._allTransitiveDependencies,
          query: query,
          type: type,
          city: city,
        );

  MockOrganizationSearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.type,
    required this.city,
  }) : super.internal();

  final String? query;
  final String? type;
  final String? city;

  @override
  Override overrideWith(
    FutureOr<List<OrganizationCard>> Function(
            MockOrganizationSearchRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MockOrganizationSearchProvider._internal(
        (ref) => create(ref as MockOrganizationSearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        type: type,
        city: city,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrganizationCard>> createElement() {
    return _MockOrganizationSearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MockOrganizationSearchProvider &&
        other.query == query &&
        other.type == type &&
        other.city == city;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, city.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MockOrganizationSearchRef
    on AutoDisposeFutureProviderRef<List<OrganizationCard>> {
  /// The parameter `query` of this provider.
  String? get query;

  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `city` of this provider.
  String? get city;
}

class _MockOrganizationSearchProviderElement
    extends AutoDisposeFutureProviderElement<List<OrganizationCard>>
    with MockOrganizationSearchRef {
  _MockOrganizationSearchProviderElement(super.provider);

  @override
  String? get query => (origin as MockOrganizationSearchProvider).query;
  @override
  String? get type => (origin as MockOrganizationSearchProvider).type;
  @override
  String? get city => (origin as MockOrganizationSearchProvider).city;
}

String _$mockFavoritesDataHash() => r'fa0fd08966bfb3bad997c168ecb41bfabff7b01c';

/// See also [mockFavoritesData].
@ProviderFor(mockFavoritesData)
final mockFavoritesDataProvider =
    AutoDisposeFutureProvider<List<OrganizationCard>>.internal(
  mockFavoritesData,
  name: r'mockFavoritesDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mockFavoritesDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MockFavoritesDataRef
    = AutoDisposeFutureProviderRef<List<OrganizationCard>>;
String _$mockBranchDataHash() => r'79b8063ae3bd49decf85f78f916c71781f0a937d';

/// See also [mockBranchData].
@ProviderFor(mockBranchData)
const mockBranchDataProvider = MockBranchDataFamily();

/// See also [mockBranchData].
class MockBranchDataFamily extends Family<AsyncValue<BranchDetail>> {
  /// See also [mockBranchData].
  const MockBranchDataFamily();

  /// See also [mockBranchData].
  MockBranchDataProvider call(
    String branchId,
  ) {
    return MockBranchDataProvider(
      branchId,
    );
  }

  @override
  MockBranchDataProvider getProviderOverride(
    covariant MockBranchDataProvider provider,
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
  String? get name => r'mockBranchDataProvider';
}

/// See also [mockBranchData].
class MockBranchDataProvider extends AutoDisposeFutureProvider<BranchDetail> {
  /// See also [mockBranchData].
  MockBranchDataProvider(
    String branchId,
  ) : this._internal(
          (ref) => mockBranchData(
            ref as MockBranchDataRef,
            branchId,
          ),
          from: mockBranchDataProvider,
          name: r'mockBranchDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mockBranchDataHash,
          dependencies: MockBranchDataFamily._dependencies,
          allTransitiveDependencies:
              MockBranchDataFamily._allTransitiveDependencies,
          branchId: branchId,
        );

  MockBranchDataProvider._internal(
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
    FutureOr<BranchDetail> Function(MockBranchDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MockBranchDataProvider._internal(
        (ref) => create(ref as MockBranchDataRef),
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
    return _MockBranchDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MockBranchDataProvider && other.branchId == branchId;
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
mixin MockBranchDataRef on AutoDisposeFutureProviderRef<BranchDetail> {
  /// The parameter `branchId` of this provider.
  String get branchId;
}

class _MockBranchDataProviderElement
    extends AutoDisposeFutureProviderElement<BranchDetail>
    with MockBranchDataRef {
  _MockBranchDataProviderElement(super.provider);

  @override
  String get branchId => (origin as MockBranchDataProvider).branchId;
}

String _$mockTicketHistoryDataHash() =>
    r'81b0248b1a0eb42110e6b9ca3b7cc0539ab8cede';

/// See also [mockTicketHistoryData].
@ProviderFor(mockTicketHistoryData)
const mockTicketHistoryDataProvider = MockTicketHistoryDataFamily();

/// See also [mockTicketHistoryData].
class MockTicketHistoryDataFamily
    extends Family<AsyncValue<List<TicketModel>>> {
  /// See also [mockTicketHistoryData].
  const MockTicketHistoryDataFamily();

  /// See also [mockTicketHistoryData].
  MockTicketHistoryDataProvider call({
    String? status,
  }) {
    return MockTicketHistoryDataProvider(
      status: status,
    );
  }

  @override
  MockTicketHistoryDataProvider getProviderOverride(
    covariant MockTicketHistoryDataProvider provider,
  ) {
    return call(
      status: provider.status,
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
  String? get name => r'mockTicketHistoryDataProvider';
}

/// See also [mockTicketHistoryData].
class MockTicketHistoryDataProvider
    extends AutoDisposeFutureProvider<List<TicketModel>> {
  /// See also [mockTicketHistoryData].
  MockTicketHistoryDataProvider({
    String? status,
  }) : this._internal(
          (ref) => mockTicketHistoryData(
            ref as MockTicketHistoryDataRef,
            status: status,
          ),
          from: mockTicketHistoryDataProvider,
          name: r'mockTicketHistoryDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mockTicketHistoryDataHash,
          dependencies: MockTicketHistoryDataFamily._dependencies,
          allTransitiveDependencies:
              MockTicketHistoryDataFamily._allTransitiveDependencies,
          status: status,
        );

  MockTicketHistoryDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  Override overrideWith(
    FutureOr<List<TicketModel>> Function(MockTicketHistoryDataRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MockTicketHistoryDataProvider._internal(
        (ref) => create(ref as MockTicketHistoryDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TicketModel>> createElement() {
    return _MockTicketHistoryDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MockTicketHistoryDataProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MockTicketHistoryDataRef
    on AutoDisposeFutureProviderRef<List<TicketModel>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _MockTicketHistoryDataProviderElement
    extends AutoDisposeFutureProviderElement<List<TicketModel>>
    with MockTicketHistoryDataRef {
  _MockTicketHistoryDataProviderElement(super.provider);

  @override
  String? get status => (origin as MockTicketHistoryDataProvider).status;
}

String _$mockAuthNotifierHash() => r'ebebd64fe3af7519c8ae40169076beb386f08d97';

/// See also [MockAuthNotifier].
@ProviderFor(MockAuthNotifier)
final mockAuthNotifierProvider = AutoDisposeNotifierProvider<MockAuthNotifier,
    AsyncValue<UserModel?>>.internal(
  MockAuthNotifier.new,
  name: r'mockAuthNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mockAuthNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MockAuthNotifier = AutoDisposeNotifier<AsyncValue<UserModel?>>;
String _$mockCreateTicketHash() => r'7ffd29a63db774e6f805223a87ece8699b314fdc';

/// See also [MockCreateTicket].
@ProviderFor(MockCreateTicket)
final mockCreateTicketProvider = AutoDisposeNotifierProvider<MockCreateTicket,
    AsyncValue<TicketModel?>>.internal(
  MockCreateTicket.new,
  name: r'mockCreateTicketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mockCreateTicketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MockCreateTicket = AutoDisposeNotifier<AsyncValue<TicketModel?>>;
String _$mockCancelTicketHash() => r'9f617a46cf1ecb7eca3d2df125424037c20d6dec';

/// See also [MockCancelTicket].
@ProviderFor(MockCancelTicket)
final mockCancelTicketProvider =
    AutoDisposeNotifierProvider<MockCancelTicket, AsyncValue<void>>.internal(
  MockCancelTicket.new,
  name: r'mockCancelTicketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mockCancelTicketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MockCancelTicket = AutoDisposeNotifier<AsyncValue<void>>;
String _$mockFeedbackHash() => r'f2ae64e2c1fa5c199819d521f0a5a69d7207b12c';

/// See also [MockFeedback].
@ProviderFor(MockFeedback)
final mockFeedbackProvider =
    AutoDisposeNotifierProvider<MockFeedback, AsyncValue<void>>.internal(
  MockFeedback.new,
  name: r'mockFeedbackProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mockFeedbackHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MockFeedback = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
