// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketStreamHash() => r'1a6af5a40714bdcbbf0df5e6dfd9d97a6cc002f1';

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

/// See also [ticketStream].
@ProviderFor(ticketStream)
const ticketStreamProvider = TicketStreamFamily();

/// See also [ticketStream].
class TicketStreamFamily extends Family<AsyncValue<TicketModel>> {
  /// See also [ticketStream].
  const TicketStreamFamily();

  /// See also [ticketStream].
  TicketStreamProvider call(
    String ticketId,
  ) {
    return TicketStreamProvider(
      ticketId,
    );
  }

  @override
  TicketStreamProvider getProviderOverride(
    covariant TicketStreamProvider provider,
  ) {
    return call(
      provider.ticketId,
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
  String? get name => r'ticketStreamProvider';
}

/// See also [ticketStream].
class TicketStreamProvider extends AutoDisposeStreamProvider<TicketModel> {
  /// See also [ticketStream].
  TicketStreamProvider(
    String ticketId,
  ) : this._internal(
          (ref) => ticketStream(
            ref as TicketStreamRef,
            ticketId,
          ),
          from: ticketStreamProvider,
          name: r'ticketStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ticketStreamHash,
          dependencies: TicketStreamFamily._dependencies,
          allTransitiveDependencies:
              TicketStreamFamily._allTransitiveDependencies,
          ticketId: ticketId,
        );

  TicketStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ticketId,
  }) : super.internal();

  final String ticketId;

  @override
  Override overrideWith(
    Stream<TicketModel> Function(TicketStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TicketStreamProvider._internal(
        (ref) => create(ref as TicketStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ticketId: ticketId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<TicketModel> createElement() {
    return _TicketStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketStreamProvider && other.ticketId == ticketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ticketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TicketStreamRef on AutoDisposeStreamProviderRef<TicketModel> {
  /// The parameter `ticketId` of this provider.
  String get ticketId;
}

class _TicketStreamProviderElement
    extends AutoDisposeStreamProviderElement<TicketModel> with TicketStreamRef {
  _TicketStreamProviderElement(super.provider);

  @override
  String get ticketId => (origin as TicketStreamProvider).ticketId;
}

String _$myTicketsHash() => r'a4d094cd37f87044b7eddb97c34802bab6362280';

/// See also [myTickets].
@ProviderFor(myTickets)
const myTicketsProvider = MyTicketsFamily();

/// See also [myTickets].
class MyTicketsFamily extends Family<AsyncValue<List<TicketModel>>> {
  /// See also [myTickets].
  const MyTicketsFamily();

  /// See also [myTickets].
  MyTicketsProvider call({
    String? status,
  }) {
    return MyTicketsProvider(
      status: status,
    );
  }

  @override
  MyTicketsProvider getProviderOverride(
    covariant MyTicketsProvider provider,
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
  String? get name => r'myTicketsProvider';
}

/// See also [myTickets].
class MyTicketsProvider extends AutoDisposeFutureProvider<List<TicketModel>> {
  /// See also [myTickets].
  MyTicketsProvider({
    String? status,
  }) : this._internal(
          (ref) => myTickets(
            ref as MyTicketsRef,
            status: status,
          ),
          from: myTicketsProvider,
          name: r'myTicketsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myTicketsHash,
          dependencies: MyTicketsFamily._dependencies,
          allTransitiveDependencies: MyTicketsFamily._allTransitiveDependencies,
          status: status,
        );

  MyTicketsProvider._internal(
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
    FutureOr<List<TicketModel>> Function(MyTicketsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyTicketsProvider._internal(
        (ref) => create(ref as MyTicketsRef),
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
    return _MyTicketsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyTicketsProvider && other.status == status;
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
mixin MyTicketsRef on AutoDisposeFutureProviderRef<List<TicketModel>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _MyTicketsProviderElement
    extends AutoDisposeFutureProviderElement<List<TicketModel>>
    with MyTicketsRef {
  _MyTicketsProviderElement(super.provider);

  @override
  String? get status => (origin as MyTicketsProvider).status;
}

String _$createTicketNotifierHash() =>
    r'067592f7c46bd121c3ca41d1ca75d2b4d4a09780';

/// See also [CreateTicketNotifier].
@ProviderFor(CreateTicketNotifier)
final createTicketNotifierProvider = AutoDisposeNotifierProvider<
    CreateTicketNotifier, AsyncValue<TicketModel?>>.internal(
  CreateTicketNotifier.new,
  name: r'createTicketNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createTicketNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateTicketNotifier = AutoDisposeNotifier<AsyncValue<TicketModel?>>;
String _$cancelTicketNotifierHash() =>
    r'0e1a657480f7a92132462eae8567063ce835e399';

/// See also [CancelTicketNotifier].
@ProviderFor(CancelTicketNotifier)
final cancelTicketNotifierProvider = AutoDisposeNotifierProvider<
    CancelTicketNotifier, AsyncValue<void>>.internal(
  CancelTicketNotifier.new,
  name: r'cancelTicketNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cancelTicketNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CancelTicketNotifier = AutoDisposeNotifier<AsyncValue<void>>;
String _$feedbackNotifierHash() => r'663327bf99ec05f24c66076ec5f56cb3ec6e5ba6';

/// See also [FeedbackNotifier].
@ProviderFor(FeedbackNotifier)
final feedbackNotifierProvider =
    AutoDisposeNotifierProvider<FeedbackNotifier, AsyncValue<void>>.internal(
  FeedbackNotifier.new,
  name: r'feedbackNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedbackNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FeedbackNotifier = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
