// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceSummary _$ServiceSummaryFromJson(Map<String, dynamic> json) {
  return _ServiceSummary.fromJson(json);
}

/// @nodoc
mixin _$ServiceSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  int? get waitingCount => throw _privateConstructorUsedError;
  int? get avgWaitMin => throw _privateConstructorUsedError;

  /// Serializes this ServiceSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceSummaryCopyWith<ServiceSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceSummaryCopyWith<$Res> {
  factory $ServiceSummaryCopyWith(
          ServiceSummary value, $Res Function(ServiceSummary) then) =
      _$ServiceSummaryCopyWithImpl<$Res, ServiceSummary>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? icon,
      String? color,
      int? waitingCount,
      int? avgWaitMin});
}

/// @nodoc
class _$ServiceSummaryCopyWithImpl<$Res, $Val extends ServiceSummary>
    implements $ServiceSummaryCopyWith<$Res> {
  _$ServiceSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? color = freezed,
    Object? waitingCount = freezed,
    Object? avgWaitMin = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      waitingCount: freezed == waitingCount
          ? _value.waitingCount
          : waitingCount // ignore: cast_nullable_to_non_nullable
              as int?,
      avgWaitMin: freezed == avgWaitMin
          ? _value.avgWaitMin
          : avgWaitMin // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceSummaryImplCopyWith<$Res>
    implements $ServiceSummaryCopyWith<$Res> {
  factory _$$ServiceSummaryImplCopyWith(_$ServiceSummaryImpl value,
          $Res Function(_$ServiceSummaryImpl) then) =
      __$$ServiceSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? icon,
      String? color,
      int? waitingCount,
      int? avgWaitMin});
}

/// @nodoc
class __$$ServiceSummaryImplCopyWithImpl<$Res>
    extends _$ServiceSummaryCopyWithImpl<$Res, _$ServiceSummaryImpl>
    implements _$$ServiceSummaryImplCopyWith<$Res> {
  __$$ServiceSummaryImplCopyWithImpl(
      _$ServiceSummaryImpl _value, $Res Function(_$ServiceSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? color = freezed,
    Object? waitingCount = freezed,
    Object? avgWaitMin = freezed,
  }) {
    return _then(_$ServiceSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      waitingCount: freezed == waitingCount
          ? _value.waitingCount
          : waitingCount // ignore: cast_nullable_to_non_nullable
              as int?,
      avgWaitMin: freezed == avgWaitMin
          ? _value.avgWaitMin
          : avgWaitMin // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceSummaryImpl implements _ServiceSummary {
  const _$ServiceSummaryImpl(
      {required this.id,
      required this.name,
      this.icon,
      this.color,
      this.waitingCount,
      this.avgWaitMin});

  factory _$ServiceSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? icon;
  @override
  final String? color;
  @override
  final int? waitingCount;
  @override
  final int? avgWaitMin;

  @override
  String toString() {
    return 'ServiceSummary(id: $id, name: $name, icon: $icon, color: $color, waitingCount: $waitingCount, avgWaitMin: $avgWaitMin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.waitingCount, waitingCount) ||
                other.waitingCount == waitingCount) &&
            (identical(other.avgWaitMin, avgWaitMin) ||
                other.avgWaitMin == avgWaitMin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, icon, color, waitingCount, avgWaitMin);

  /// Create a copy of ServiceSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceSummaryImplCopyWith<_$ServiceSummaryImpl> get copyWith =>
      __$$ServiceSummaryImplCopyWithImpl<_$ServiceSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceSummaryImplToJson(
      this,
    );
  }
}

abstract class _ServiceSummary implements ServiceSummary {
  const factory _ServiceSummary(
      {required final String id,
      required final String name,
      final String? icon,
      final String? color,
      final int? waitingCount,
      final int? avgWaitMin}) = _$ServiceSummaryImpl;

  factory _ServiceSummary.fromJson(Map<String, dynamic> json) =
      _$ServiceSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get icon;
  @override
  String? get color;
  @override
  int? get waitingCount;
  @override
  int? get avgWaitMin;

  /// Create a copy of ServiceSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceSummaryImplCopyWith<_$ServiceSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueueSummary _$QueueSummaryFromJson(Map<String, dynamic> json) {
  return _QueueSummary.fromJson(json);
}

/// @nodoc
mixin _$QueueSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int? get waitingCount => throw _privateConstructorUsedError;
  int? get avgWaitMin => throw _privateConstructorUsedError;
  ServiceSummary get service => throw _privateConstructorUsedError;

  /// Serializes this QueueSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSummaryCopyWith<QueueSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSummaryCopyWith<$Res> {
  factory $QueueSummaryCopyWith(
          QueueSummary value, $Res Function(QueueSummary) then) =
      _$QueueSummaryCopyWithImpl<$Res, QueueSummary>;
  @useResult
  $Res call(
      {String id,
      String name,
      String status,
      int? waitingCount,
      int? avgWaitMin,
      ServiceSummary service});

  $ServiceSummaryCopyWith<$Res> get service;
}

/// @nodoc
class _$QueueSummaryCopyWithImpl<$Res, $Val extends QueueSummary>
    implements $QueueSummaryCopyWith<$Res> {
  _$QueueSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? waitingCount = freezed,
    Object? avgWaitMin = freezed,
    Object? service = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      waitingCount: freezed == waitingCount
          ? _value.waitingCount
          : waitingCount // ignore: cast_nullable_to_non_nullable
              as int?,
      avgWaitMin: freezed == avgWaitMin
          ? _value.avgWaitMin
          : avgWaitMin // ignore: cast_nullable_to_non_nullable
              as int?,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceSummary,
    ) as $Val);
  }

  /// Create a copy of QueueSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceSummaryCopyWith<$Res> get service {
    return $ServiceSummaryCopyWith<$Res>(_value.service, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueSummaryImplCopyWith<$Res>
    implements $QueueSummaryCopyWith<$Res> {
  factory _$$QueueSummaryImplCopyWith(
          _$QueueSummaryImpl value, $Res Function(_$QueueSummaryImpl) then) =
      __$$QueueSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String status,
      int? waitingCount,
      int? avgWaitMin,
      ServiceSummary service});

  @override
  $ServiceSummaryCopyWith<$Res> get service;
}

/// @nodoc
class __$$QueueSummaryImplCopyWithImpl<$Res>
    extends _$QueueSummaryCopyWithImpl<$Res, _$QueueSummaryImpl>
    implements _$$QueueSummaryImplCopyWith<$Res> {
  __$$QueueSummaryImplCopyWithImpl(
      _$QueueSummaryImpl _value, $Res Function(_$QueueSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? status = null,
    Object? waitingCount = freezed,
    Object? avgWaitMin = freezed,
    Object? service = null,
  }) {
    return _then(_$QueueSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      waitingCount: freezed == waitingCount
          ? _value.waitingCount
          : waitingCount // ignore: cast_nullable_to_non_nullable
              as int?,
      avgWaitMin: freezed == avgWaitMin
          ? _value.avgWaitMin
          : avgWaitMin // ignore: cast_nullable_to_non_nullable
              as int?,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceSummary,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueSummaryImpl implements _QueueSummary {
  const _$QueueSummaryImpl(
      {required this.id,
      required this.name,
      required this.status,
      this.waitingCount,
      this.avgWaitMin,
      required this.service});

  factory _$QueueSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String status;
  @override
  final int? waitingCount;
  @override
  final int? avgWaitMin;
  @override
  final ServiceSummary service;

  @override
  String toString() {
    return 'QueueSummary(id: $id, name: $name, status: $status, waitingCount: $waitingCount, avgWaitMin: $avgWaitMin, service: $service)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.waitingCount, waitingCount) ||
                other.waitingCount == waitingCount) &&
            (identical(other.avgWaitMin, avgWaitMin) ||
                other.avgWaitMin == avgWaitMin) &&
            (identical(other.service, service) || other.service == service));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, status, waitingCount, avgWaitMin, service);

  /// Create a copy of QueueSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSummaryImplCopyWith<_$QueueSummaryImpl> get copyWith =>
      __$$QueueSummaryImplCopyWithImpl<_$QueueSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueSummaryImplToJson(
      this,
    );
  }
}

abstract class _QueueSummary implements QueueSummary {
  const factory _QueueSummary(
      {required final String id,
      required final String name,
      required final String status,
      final int? waitingCount,
      final int? avgWaitMin,
      required final ServiceSummary service}) = _$QueueSummaryImpl;

  factory _QueueSummary.fromJson(Map<String, dynamic> json) =
      _$QueueSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get status;
  @override
  int? get waitingCount;
  @override
  int? get avgWaitMin;
  @override
  ServiceSummary get service;

  /// Create a copy of QueueSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSummaryImplCopyWith<_$QueueSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BranchDetail _$BranchDetailFromJson(Map<String, dynamic> json) {
  return _BranchDetail.fromJson(json);
}

/// @nodoc
mixin _$BranchDetail {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  bool get openNow => throw _privateConstructorUsedError;
  String? get openUntil => throw _privateConstructorUsedError;
  List<QueueSummary> get queues => throw _privateConstructorUsedError;

  /// Serializes this BranchDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BranchDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchDetailCopyWith<BranchDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchDetailCopyWith<$Res> {
  factory $BranchDetailCopyWith(
          BranchDetail value, $Res Function(BranchDetail) then) =
      _$BranchDetailCopyWithImpl<$Res, BranchDetail>;
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String city,
      String? phone,
      double? latitude,
      double? longitude,
      bool openNow,
      String? openUntil,
      List<QueueSummary> queues});
}

/// @nodoc
class _$BranchDetailCopyWithImpl<$Res, $Val extends BranchDetail>
    implements $BranchDetailCopyWith<$Res> {
  _$BranchDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BranchDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? city = null,
    Object? phone = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? openNow = null,
    Object? openUntil = freezed,
    Object? queues = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      openNow: null == openNow
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool,
      openUntil: freezed == openUntil
          ? _value.openUntil
          : openUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      queues: null == queues
          ? _value.queues
          : queues // ignore: cast_nullable_to_non_nullable
              as List<QueueSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchDetailImplCopyWith<$Res>
    implements $BranchDetailCopyWith<$Res> {
  factory _$$BranchDetailImplCopyWith(
          _$BranchDetailImpl value, $Res Function(_$BranchDetailImpl) then) =
      __$$BranchDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String address,
      String city,
      String? phone,
      double? latitude,
      double? longitude,
      bool openNow,
      String? openUntil,
      List<QueueSummary> queues});
}

/// @nodoc
class __$$BranchDetailImplCopyWithImpl<$Res>
    extends _$BranchDetailCopyWithImpl<$Res, _$BranchDetailImpl>
    implements _$$BranchDetailImplCopyWith<$Res> {
  __$$BranchDetailImplCopyWithImpl(
      _$BranchDetailImpl _value, $Res Function(_$BranchDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of BranchDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? city = null,
    Object? phone = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? openNow = null,
    Object? openUntil = freezed,
    Object? queues = null,
  }) {
    return _then(_$BranchDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      openNow: null == openNow
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool,
      openUntil: freezed == openUntil
          ? _value.openUntil
          : openUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      queues: null == queues
          ? _value._queues
          : queues // ignore: cast_nullable_to_non_nullable
              as List<QueueSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchDetailImpl implements _BranchDetail {
  const _$BranchDetailImpl(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      this.phone,
      this.latitude,
      this.longitude,
      this.openNow = false,
      this.openUntil,
      final List<QueueSummary> queues = const []})
      : _queues = queues;

  factory _$BranchDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String city;
  @override
  final String? phone;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final bool openNow;
  @override
  final String? openUntil;
  final List<QueueSummary> _queues;
  @override
  @JsonKey()
  List<QueueSummary> get queues {
    if (_queues is EqualUnmodifiableListView) return _queues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queues);
  }

  @override
  String toString() {
    return 'BranchDetail(id: $id, name: $name, address: $address, city: $city, phone: $phone, latitude: $latitude, longitude: $longitude, openNow: $openNow, openUntil: $openUntil, queues: $queues)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.openNow, openNow) || other.openNow == openNow) &&
            (identical(other.openUntil, openUntil) ||
                other.openUntil == openUntil) &&
            const DeepCollectionEquality().equals(other._queues, _queues));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      address,
      city,
      phone,
      latitude,
      longitude,
      openNow,
      openUntil,
      const DeepCollectionEquality().hash(_queues));

  /// Create a copy of BranchDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchDetailImplCopyWith<_$BranchDetailImpl> get copyWith =>
      __$$BranchDetailImplCopyWithImpl<_$BranchDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchDetailImplToJson(
      this,
    );
  }
}

abstract class _BranchDetail implements BranchDetail {
  const factory _BranchDetail(
      {required final String id,
      required final String name,
      required final String address,
      required final String city,
      final String? phone,
      final double? latitude,
      final double? longitude,
      final bool openNow,
      final String? openUntil,
      final List<QueueSummary> queues}) = _$BranchDetailImpl;

  factory _BranchDetail.fromJson(Map<String, dynamic> json) =
      _$BranchDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String get city;
  @override
  String? get phone;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  bool get openNow;
  @override
  String? get openUntil;
  @override
  List<QueueSummary> get queues;

  /// Create a copy of BranchDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchDetailImplCopyWith<_$BranchDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BranchSummary _$BranchSummaryFromJson(Map<String, dynamic> json) {
  return _BranchSummary.fromJson(json);
}

/// @nodoc
mixin _$BranchSummary {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  bool get openNow => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;

  /// Serializes this BranchSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BranchSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchSummaryCopyWith<BranchSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchSummaryCopyWith<$Res> {
  factory $BranchSummaryCopyWith(
          BranchSummary value, $Res Function(BranchSummary) then) =
      _$BranchSummaryCopyWithImpl<$Res, BranchSummary>;
  @useResult
  $Res call(
      {String id, String name, String city, bool openNow, double? distance});
}

/// @nodoc
class _$BranchSummaryCopyWithImpl<$Res, $Val extends BranchSummary>
    implements $BranchSummaryCopyWith<$Res> {
  _$BranchSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BranchSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = null,
    Object? openNow = null,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      openNow: null == openNow
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchSummaryImplCopyWith<$Res>
    implements $BranchSummaryCopyWith<$Res> {
  factory _$$BranchSummaryImplCopyWith(
          _$BranchSummaryImpl value, $Res Function(_$BranchSummaryImpl) then) =
      __$$BranchSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, String city, bool openNow, double? distance});
}

/// @nodoc
class __$$BranchSummaryImplCopyWithImpl<$Res>
    extends _$BranchSummaryCopyWithImpl<$Res, _$BranchSummaryImpl>
    implements _$$BranchSummaryImplCopyWith<$Res> {
  __$$BranchSummaryImplCopyWithImpl(
      _$BranchSummaryImpl _value, $Res Function(_$BranchSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BranchSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? city = null,
    Object? openNow = null,
    Object? distance = freezed,
  }) {
    return _then(_$BranchSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      openNow: null == openNow
          ? _value.openNow
          : openNow // ignore: cast_nullable_to_non_nullable
              as bool,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchSummaryImpl implements _BranchSummary {
  const _$BranchSummaryImpl(
      {required this.id,
      required this.name,
      required this.city,
      this.openNow = false,
      this.distance});

  factory _$BranchSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String city;
  @override
  @JsonKey()
  final bool openNow;
  @override
  final double? distance;

  @override
  String toString() {
    return 'BranchSummary(id: $id, name: $name, city: $city, openNow: $openNow, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.openNow, openNow) || other.openNow == openNow) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, city, openNow, distance);

  /// Create a copy of BranchSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchSummaryImplCopyWith<_$BranchSummaryImpl> get copyWith =>
      __$$BranchSummaryImplCopyWithImpl<_$BranchSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchSummaryImplToJson(
      this,
    );
  }
}

abstract class _BranchSummary implements BranchSummary {
  const factory _BranchSummary(
      {required final String id,
      required final String name,
      required final String city,
      final bool openNow,
      final double? distance}) = _$BranchSummaryImpl;

  factory _BranchSummary.fromJson(Map<String, dynamic> json) =
      _$BranchSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get city;
  @override
  bool get openNow;
  @override
  double? get distance;

  /// Create a copy of BranchSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchSummaryImplCopyWith<_$BranchSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationCard _$OrganizationCardFromJson(Map<String, dynamic> json) {
  return _OrganizationCard.fromJson(json);
}

/// @nodoc
mixin _$OrganizationCard {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  List<BranchSummary> get branches => throw _privateConstructorUsedError;

  /// Serializes this OrganizationCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationCardCopyWith<OrganizationCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationCardCopyWith<$Res> {
  factory $OrganizationCardCopyWith(
          OrganizationCard value, $Res Function(OrganizationCard) then) =
      _$OrganizationCardCopyWithImpl<$Res, OrganizationCard>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String? logoUrl,
      String? city,
      String? slug,
      List<BranchSummary> branches});
}

/// @nodoc
class _$OrganizationCardCopyWithImpl<$Res, $Val extends OrganizationCard>
    implements $OrganizationCardCopyWith<$Res> {
  _$OrganizationCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? logoUrl = freezed,
    Object? city = freezed,
    Object? slug = freezed,
    Object? branches = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      branches: null == branches
          ? _value.branches
          : branches // ignore: cast_nullable_to_non_nullable
              as List<BranchSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrganizationCardImplCopyWith<$Res>
    implements $OrganizationCardCopyWith<$Res> {
  factory _$$OrganizationCardImplCopyWith(_$OrganizationCardImpl value,
          $Res Function(_$OrganizationCardImpl) then) =
      __$$OrganizationCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String? logoUrl,
      String? city,
      String? slug,
      List<BranchSummary> branches});
}

/// @nodoc
class __$$OrganizationCardImplCopyWithImpl<$Res>
    extends _$OrganizationCardCopyWithImpl<$Res, _$OrganizationCardImpl>
    implements _$$OrganizationCardImplCopyWith<$Res> {
  __$$OrganizationCardImplCopyWithImpl(_$OrganizationCardImpl _value,
      $Res Function(_$OrganizationCardImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? logoUrl = freezed,
    Object? city = freezed,
    Object? slug = freezed,
    Object? branches = null,
  }) {
    return _then(_$OrganizationCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      branches: null == branches
          ? _value._branches
          : branches // ignore: cast_nullable_to_non_nullable
              as List<BranchSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationCardImpl implements _OrganizationCard {
  const _$OrganizationCardImpl(
      {required this.id,
      required this.name,
      required this.type,
      this.logoUrl,
      this.city,
      this.slug,
      final List<BranchSummary> branches = const []})
      : _branches = branches;

  factory _$OrganizationCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationCardImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String? logoUrl;
  @override
  final String? city;
  @override
  final String? slug;
  final List<BranchSummary> _branches;
  @override
  @JsonKey()
  List<BranchSummary> get branches {
    if (_branches is EqualUnmodifiableListView) return _branches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branches);
  }

  @override
  String toString() {
    return 'OrganizationCard(id: $id, name: $name, type: $type, logoUrl: $logoUrl, city: $city, slug: $slug, branches: $branches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            const DeepCollectionEquality().equals(other._branches, _branches));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, logoUrl, city,
      slug, const DeepCollectionEquality().hash(_branches));

  /// Create a copy of OrganizationCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationCardImplCopyWith<_$OrganizationCardImpl> get copyWith =>
      __$$OrganizationCardImplCopyWithImpl<_$OrganizationCardImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationCardImplToJson(
      this,
    );
  }
}

abstract class _OrganizationCard implements OrganizationCard {
  const factory _OrganizationCard(
      {required final String id,
      required final String name,
      required final String type,
      final String? logoUrl,
      final String? city,
      final String? slug,
      final List<BranchSummary> branches}) = _$OrganizationCardImpl;

  factory _OrganizationCard.fromJson(Map<String, dynamic> json) =
      _$OrganizationCardImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String? get logoUrl;
  @override
  String? get city;
  @override
  String? get slug;
  @override
  List<BranchSummary> get branches;

  /// Create a copy of OrganizationCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationCardImplCopyWith<_$OrganizationCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
