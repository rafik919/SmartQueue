// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueueInfo _$QueueInfoFromJson(Map<String, dynamic> json) {
  return _QueueInfo.fromJson(json);
}

/// @nodoc
mixin _$QueueInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get prefix => throw _privateConstructorUsedError;
  int? get waitingCount => throw _privateConstructorUsedError;

  /// Serializes this QueueInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueInfoCopyWith<QueueInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueInfoCopyWith<$Res> {
  factory $QueueInfoCopyWith(QueueInfo value, $Res Function(QueueInfo) then) =
      _$QueueInfoCopyWithImpl<$Res, QueueInfo>;
  @useResult
  $Res call({String id, String name, String prefix, int? waitingCount});
}

/// @nodoc
class _$QueueInfoCopyWithImpl<$Res, $Val extends QueueInfo>
    implements $QueueInfoCopyWith<$Res> {
  _$QueueInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? prefix = null,
    Object? waitingCount = freezed,
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
      prefix: null == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      waitingCount: freezed == waitingCount
          ? _value.waitingCount
          : waitingCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueueInfoImplCopyWith<$Res>
    implements $QueueInfoCopyWith<$Res> {
  factory _$$QueueInfoImplCopyWith(
          _$QueueInfoImpl value, $Res Function(_$QueueInfoImpl) then) =
      __$$QueueInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String prefix, int? waitingCount});
}

/// @nodoc
class __$$QueueInfoImplCopyWithImpl<$Res>
    extends _$QueueInfoCopyWithImpl<$Res, _$QueueInfoImpl>
    implements _$$QueueInfoImplCopyWith<$Res> {
  __$$QueueInfoImplCopyWithImpl(
      _$QueueInfoImpl _value, $Res Function(_$QueueInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? prefix = null,
    Object? waitingCount = freezed,
  }) {
    return _then(_$QueueInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefix: null == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as String,
      waitingCount: freezed == waitingCount
          ? _value.waitingCount
          : waitingCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueInfoImpl implements _QueueInfo {
  const _$QueueInfoImpl(
      {required this.id,
      required this.name,
      required this.prefix,
      this.waitingCount});

  factory _$QueueInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String prefix;
  @override
  final int? waitingCount;

  @override
  String toString() {
    return 'QueueInfo(id: $id, name: $name, prefix: $prefix, waitingCount: $waitingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.prefix, prefix) || other.prefix == prefix) &&
            (identical(other.waitingCount, waitingCount) ||
                other.waitingCount == waitingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, prefix, waitingCount);

  /// Create a copy of QueueInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueInfoImplCopyWith<_$QueueInfoImpl> get copyWith =>
      __$$QueueInfoImplCopyWithImpl<_$QueueInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueInfoImplToJson(
      this,
    );
  }
}

abstract class _QueueInfo implements QueueInfo {
  const factory _QueueInfo(
      {required final String id,
      required final String name,
      required final String prefix,
      final int? waitingCount}) = _$QueueInfoImpl;

  factory _QueueInfo.fromJson(Map<String, dynamic> json) =
      _$QueueInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get prefix;
  @override
  int? get waitingCount;

  /// Create a copy of QueueInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueInfoImplCopyWith<_$QueueInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceInfo _$ServiceInfoFromJson(Map<String, dynamic> json) {
  return _ServiceInfo.fromJson(json);
}

/// @nodoc
mixin _$ServiceInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this ServiceInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceInfoCopyWith<ServiceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceInfoCopyWith<$Res> {
  factory $ServiceInfoCopyWith(
          ServiceInfo value, $Res Function(ServiceInfo) then) =
      _$ServiceInfoCopyWithImpl<$Res, ServiceInfo>;
  @useResult
  $Res call({String id, String name, String? icon, String? color});
}

/// @nodoc
class _$ServiceInfoCopyWithImpl<$Res, $Val extends ServiceInfo>
    implements $ServiceInfoCopyWith<$Res> {
  _$ServiceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? color = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceInfoImplCopyWith<$Res>
    implements $ServiceInfoCopyWith<$Res> {
  factory _$$ServiceInfoImplCopyWith(
          _$ServiceInfoImpl value, $Res Function(_$ServiceInfoImpl) then) =
      __$$ServiceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? icon, String? color});
}

/// @nodoc
class __$$ServiceInfoImplCopyWithImpl<$Res>
    extends _$ServiceInfoCopyWithImpl<$Res, _$ServiceInfoImpl>
    implements _$$ServiceInfoImplCopyWith<$Res> {
  __$$ServiceInfoImplCopyWithImpl(
      _$ServiceInfoImpl _value, $Res Function(_$ServiceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = freezed,
    Object? color = freezed,
  }) {
    return _then(_$ServiceInfoImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceInfoImpl implements _ServiceInfo {
  const _$ServiceInfoImpl(
      {required this.id, required this.name, this.icon, this.color});

  factory _$ServiceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? icon;
  @override
  final String? color;

  @override
  String toString() {
    return 'ServiceInfo(id: $id, name: $name, icon: $icon, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, color);

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      __$$ServiceInfoImplCopyWithImpl<_$ServiceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceInfoImplToJson(
      this,
    );
  }
}

abstract class _ServiceInfo implements ServiceInfo {
  const factory _ServiceInfo(
      {required final String id,
      required final String name,
      final String? icon,
      final String? color}) = _$ServiceInfoImpl;

  factory _ServiceInfo.fromJson(Map<String, dynamic> json) =
      _$ServiceInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get icon;
  @override
  String? get color;

  /// Create a copy of ServiceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceInfoImplCopyWith<_$ServiceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BranchInfo _$BranchInfoFromJson(Map<String, dynamic> json) {
  return _BranchInfo.fromJson(json);
}

/// @nodoc
mixin _$BranchInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  /// Serializes this BranchInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BranchInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchInfoCopyWith<BranchInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchInfoCopyWith<$Res> {
  factory $BranchInfoCopyWith(
          BranchInfo value, $Res Function(BranchInfo) then) =
      _$BranchInfoCopyWithImpl<$Res, BranchInfo>;
  @useResult
  $Res call({String id, String name, String address, String? city});
}

/// @nodoc
class _$BranchInfoCopyWithImpl<$Res, $Val extends BranchInfo>
    implements $BranchInfoCopyWith<$Res> {
  _$BranchInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BranchInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? city = freezed,
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
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchInfoImplCopyWith<$Res>
    implements $BranchInfoCopyWith<$Res> {
  factory _$$BranchInfoImplCopyWith(
          _$BranchInfoImpl value, $Res Function(_$BranchInfoImpl) then) =
      __$$BranchInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String address, String? city});
}

/// @nodoc
class __$$BranchInfoImplCopyWithImpl<$Res>
    extends _$BranchInfoCopyWithImpl<$Res, _$BranchInfoImpl>
    implements _$$BranchInfoImplCopyWith<$Res> {
  __$$BranchInfoImplCopyWithImpl(
      _$BranchInfoImpl _value, $Res Function(_$BranchInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BranchInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? city = freezed,
  }) {
    return _then(_$BranchInfoImpl(
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
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchInfoImpl implements _BranchInfo {
  const _$BranchInfoImpl(
      {required this.id, required this.name, required this.address, this.city});

  factory _$BranchInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String? city;

  @override
  String toString() {
    return 'BranchInfo(id: $id, name: $name, address: $address, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address, city);

  /// Create a copy of BranchInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchInfoImplCopyWith<_$BranchInfoImpl> get copyWith =>
      __$$BranchInfoImplCopyWithImpl<_$BranchInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchInfoImplToJson(
      this,
    );
  }
}

abstract class _BranchInfo implements BranchInfo {
  const factory _BranchInfo(
      {required final String id,
      required final String name,
      required final String address,
      final String? city}) = _$BranchInfoImpl;

  factory _BranchInfo.fromJson(Map<String, dynamic> json) =
      _$BranchInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String? get city;

  /// Create a copy of BranchInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchInfoImplCopyWith<_$BranchInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CounterInfo _$CounterInfoFromJson(Map<String, dynamic> json) {
  return _CounterInfo.fromJson(json);
}

/// @nodoc
mixin _$CounterInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;

  /// Serializes this CounterInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CounterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CounterInfoCopyWith<CounterInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterInfoCopyWith<$Res> {
  factory $CounterInfoCopyWith(
          CounterInfo value, $Res Function(CounterInfo) then) =
      _$CounterInfoCopyWithImpl<$Res, CounterInfo>;
  @useResult
  $Res call({String id, String name, int number});
}

/// @nodoc
class _$CounterInfoCopyWithImpl<$Res, $Val extends CounterInfo>
    implements $CounterInfoCopyWith<$Res> {
  _$CounterInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CounterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? number = null,
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
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CounterInfoImplCopyWith<$Res>
    implements $CounterInfoCopyWith<$Res> {
  factory _$$CounterInfoImplCopyWith(
          _$CounterInfoImpl value, $Res Function(_$CounterInfoImpl) then) =
      __$$CounterInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int number});
}

/// @nodoc
class __$$CounterInfoImplCopyWithImpl<$Res>
    extends _$CounterInfoCopyWithImpl<$Res, _$CounterInfoImpl>
    implements _$$CounterInfoImplCopyWith<$Res> {
  __$$CounterInfoImplCopyWithImpl(
      _$CounterInfoImpl _value, $Res Function(_$CounterInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CounterInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? number = null,
  }) {
    return _then(_$CounterInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CounterInfoImpl implements _CounterInfo {
  const _$CounterInfoImpl(
      {required this.id, required this.name, required this.number});

  factory _$CounterInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CounterInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int number;

  @override
  String toString() {
    return 'CounterInfo(id: $id, name: $name, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, number);

  /// Create a copy of CounterInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterInfoImplCopyWith<_$CounterInfoImpl> get copyWith =>
      __$$CounterInfoImplCopyWithImpl<_$CounterInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CounterInfoImplToJson(
      this,
    );
  }
}

abstract class _CounterInfo implements CounterInfo {
  const factory _CounterInfo(
      {required final String id,
      required final String name,
      required final int number}) = _$CounterInfoImpl;

  factory _CounterInfo.fromJson(Map<String, dynamic> json) =
      _$CounterInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get number;

  /// Create a copy of CounterInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CounterInfoImplCopyWith<_$CounterInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) {
  return _TicketModel.fromJson(json);
}

/// @nodoc
mixin _$TicketModel {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  TicketStatus get status => throw _privateConstructorUsedError;
  int? get position => throw _privateConstructorUsedError;
  int? get estimatedWaitMin => throw _privateConstructorUsedError;
  int? get waitDurationSec => throw _privateConstructorUsedError;
  int? get serviceDurationSec => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  QueueInfo get queue => throw _privateConstructorUsedError;
  ServiceInfo get service => throw _privateConstructorUsedError;
  BranchInfo get branch => throw _privateConstructorUsedError;
  CounterInfo? get counter => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get calledAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketModelCopyWith<TicketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketModelCopyWith<$Res> {
  factory $TicketModelCopyWith(
          TicketModel value, $Res Function(TicketModel) then) =
      _$TicketModelCopyWithImpl<$Res, TicketModel>;
  @useResult
  $Res call(
      {String id,
      String code,
      int number,
      TicketStatus status,
      int? position,
      int? estimatedWaitMin,
      int? waitDurationSec,
      int? serviceDurationSec,
      String? notes,
      QueueInfo queue,
      ServiceInfo service,
      BranchInfo branch,
      CounterInfo? counter,
      DateTime createdAt,
      DateTime? calledAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      DateTime? expiresAt});

  $QueueInfoCopyWith<$Res> get queue;
  $ServiceInfoCopyWith<$Res> get service;
  $BranchInfoCopyWith<$Res> get branch;
  $CounterInfoCopyWith<$Res>? get counter;
}

/// @nodoc
class _$TicketModelCopyWithImpl<$Res, $Val extends TicketModel>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? number = null,
    Object? status = null,
    Object? position = freezed,
    Object? estimatedWaitMin = freezed,
    Object? waitDurationSec = freezed,
    Object? serviceDurationSec = freezed,
    Object? notes = freezed,
    Object? queue = null,
    Object? service = null,
    Object? branch = null,
    Object? counter = freezed,
    Object? createdAt = null,
    Object? calledAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TicketStatus,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      estimatedWaitMin: freezed == estimatedWaitMin
          ? _value.estimatedWaitMin
          : estimatedWaitMin // ignore: cast_nullable_to_non_nullable
              as int?,
      waitDurationSec: freezed == waitDurationSec
          ? _value.waitDurationSec
          : waitDurationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceDurationSec: freezed == serviceDurationSec
          ? _value.serviceDurationSec
          : serviceDurationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      queue: null == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as QueueInfo,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceInfo,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as BranchInfo,
      counter: freezed == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as CounterInfo?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calledAt: freezed == calledAt
          ? _value.calledAt
          : calledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueInfoCopyWith<$Res> get queue {
    return $QueueInfoCopyWith<$Res>(_value.queue, (value) {
      return _then(_value.copyWith(queue: value) as $Val);
    });
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServiceInfoCopyWith<$Res> get service {
    return $ServiceInfoCopyWith<$Res>(_value.service, (value) {
      return _then(_value.copyWith(service: value) as $Val);
    });
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BranchInfoCopyWith<$Res> get branch {
    return $BranchInfoCopyWith<$Res>(_value.branch, (value) {
      return _then(_value.copyWith(branch: value) as $Val);
    });
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CounterInfoCopyWith<$Res>? get counter {
    if (_value.counter == null) {
      return null;
    }

    return $CounterInfoCopyWith<$Res>(_value.counter!, (value) {
      return _then(_value.copyWith(counter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketModelImplCopyWith<$Res>
    implements $TicketModelCopyWith<$Res> {
  factory _$$TicketModelImplCopyWith(
          _$TicketModelImpl value, $Res Function(_$TicketModelImpl) then) =
      __$$TicketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String code,
      int number,
      TicketStatus status,
      int? position,
      int? estimatedWaitMin,
      int? waitDurationSec,
      int? serviceDurationSec,
      String? notes,
      QueueInfo queue,
      ServiceInfo service,
      BranchInfo branch,
      CounterInfo? counter,
      DateTime createdAt,
      DateTime? calledAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      DateTime? expiresAt});

  @override
  $QueueInfoCopyWith<$Res> get queue;
  @override
  $ServiceInfoCopyWith<$Res> get service;
  @override
  $BranchInfoCopyWith<$Res> get branch;
  @override
  $CounterInfoCopyWith<$Res>? get counter;
}

/// @nodoc
class __$$TicketModelImplCopyWithImpl<$Res>
    extends _$TicketModelCopyWithImpl<$Res, _$TicketModelImpl>
    implements _$$TicketModelImplCopyWith<$Res> {
  __$$TicketModelImplCopyWithImpl(
      _$TicketModelImpl _value, $Res Function(_$TicketModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? number = null,
    Object? status = null,
    Object? position = freezed,
    Object? estimatedWaitMin = freezed,
    Object? waitDurationSec = freezed,
    Object? serviceDurationSec = freezed,
    Object? notes = freezed,
    Object? queue = null,
    Object? service = null,
    Object? branch = null,
    Object? counter = freezed,
    Object? createdAt = null,
    Object? calledAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$TicketModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TicketStatus,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int?,
      estimatedWaitMin: freezed == estimatedWaitMin
          ? _value.estimatedWaitMin
          : estimatedWaitMin // ignore: cast_nullable_to_non_nullable
              as int?,
      waitDurationSec: freezed == waitDurationSec
          ? _value.waitDurationSec
          : waitDurationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceDurationSec: freezed == serviceDurationSec
          ? _value.serviceDurationSec
          : serviceDurationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      queue: null == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as QueueInfo,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as ServiceInfo,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as BranchInfo,
      counter: freezed == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as CounterInfo?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      calledAt: freezed == calledAt
          ? _value.calledAt
          : calledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketModelImpl implements _TicketModel {
  const _$TicketModelImpl(
      {required this.id,
      required this.code,
      required this.number,
      required this.status,
      this.position,
      this.estimatedWaitMin,
      this.waitDurationSec,
      this.serviceDurationSec,
      this.notes,
      required this.queue,
      required this.service,
      required this.branch,
      this.counter,
      required this.createdAt,
      this.calledAt,
      this.completedAt,
      this.cancelledAt,
      this.expiresAt});

  factory _$TicketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketModelImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final int number;
  @override
  final TicketStatus status;
  @override
  final int? position;
  @override
  final int? estimatedWaitMin;
  @override
  final int? waitDurationSec;
  @override
  final int? serviceDurationSec;
  @override
  final String? notes;
  @override
  final QueueInfo queue;
  @override
  final ServiceInfo service;
  @override
  final BranchInfo branch;
  @override
  final CounterInfo? counter;
  @override
  final DateTime createdAt;
  @override
  final DateTime? calledAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'TicketModel(id: $id, code: $code, number: $number, status: $status, position: $position, estimatedWaitMin: $estimatedWaitMin, waitDurationSec: $waitDurationSec, serviceDurationSec: $serviceDurationSec, notes: $notes, queue: $queue, service: $service, branch: $branch, counter: $counter, createdAt: $createdAt, calledAt: $calledAt, completedAt: $completedAt, cancelledAt: $cancelledAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.estimatedWaitMin, estimatedWaitMin) ||
                other.estimatedWaitMin == estimatedWaitMin) &&
            (identical(other.waitDurationSec, waitDurationSec) ||
                other.waitDurationSec == waitDurationSec) &&
            (identical(other.serviceDurationSec, serviceDurationSec) ||
                other.serviceDurationSec == serviceDurationSec) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.queue, queue) || other.queue == queue) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.counter, counter) || other.counter == counter) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.calledAt, calledAt) ||
                other.calledAt == calledAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      number,
      status,
      position,
      estimatedWaitMin,
      waitDurationSec,
      serviceDurationSec,
      notes,
      queue,
      service,
      branch,
      counter,
      createdAt,
      calledAt,
      completedAt,
      cancelledAt,
      expiresAt);

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketModelImplCopyWith<_$TicketModelImpl> get copyWith =>
      __$$TicketModelImplCopyWithImpl<_$TicketModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketModelImplToJson(
      this,
    );
  }
}

abstract class _TicketModel implements TicketModel {
  const factory _TicketModel(
      {required final String id,
      required final String code,
      required final int number,
      required final TicketStatus status,
      final int? position,
      final int? estimatedWaitMin,
      final int? waitDurationSec,
      final int? serviceDurationSec,
      final String? notes,
      required final QueueInfo queue,
      required final ServiceInfo service,
      required final BranchInfo branch,
      final CounterInfo? counter,
      required final DateTime createdAt,
      final DateTime? calledAt,
      final DateTime? completedAt,
      final DateTime? cancelledAt,
      final DateTime? expiresAt}) = _$TicketModelImpl;

  factory _TicketModel.fromJson(Map<String, dynamic> json) =
      _$TicketModelImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  int get number;
  @override
  TicketStatus get status;
  @override
  int? get position;
  @override
  int? get estimatedWaitMin;
  @override
  int? get waitDurationSec;
  @override
  int? get serviceDurationSec;
  @override
  String? get notes;
  @override
  QueueInfo get queue;
  @override
  ServiceInfo get service;
  @override
  BranchInfo get branch;
  @override
  CounterInfo? get counter;
  @override
  DateTime get createdAt;
  @override
  DateTime? get calledAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get cancelledAt;
  @override
  DateTime? get expiresAt;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketModelImplCopyWith<_$TicketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
