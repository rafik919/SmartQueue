// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueInfoImpl _$$QueueInfoImplFromJson(Map<String, dynamic> json) =>
    _$QueueInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      prefix: json['prefix'] as String,
      waitingCount: (json['waitingCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QueueInfoImplToJson(_$QueueInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefix': instance.prefix,
      'waitingCount': instance.waitingCount,
    };

_$ServiceInfoImpl _$$ServiceInfoImplFromJson(Map<String, dynamic> json) =>
    _$ServiceInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$ServiceInfoImplToJson(_$ServiceInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
    };

_$BranchInfoImpl _$$BranchInfoImplFromJson(Map<String, dynamic> json) =>
    _$BranchInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$$BranchInfoImplToJson(_$BranchInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
    };

_$CounterInfoImpl _$$CounterInfoImplFromJson(Map<String, dynamic> json) =>
    _$CounterInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      number: (json['number'] as num).toInt(),
    );

Map<String, dynamic> _$$CounterInfoImplToJson(_$CounterInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number': instance.number,
    };

_$TicketModelImpl _$$TicketModelImplFromJson(Map<String, dynamic> json) =>
    _$TicketModelImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      number: (json['number'] as num).toInt(),
      status: $enumDecode(_$TicketStatusEnumMap, json['status']),
      position: (json['position'] as num?)?.toInt(),
      estimatedWaitMin: (json['estimatedWaitMin'] as num?)?.toInt(),
      waitDurationSec: (json['waitDurationSec'] as num?)?.toInt(),
      serviceDurationSec: (json['serviceDurationSec'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      queue: QueueInfo.fromJson(json['queue'] as Map<String, dynamic>),
      service: ServiceInfo.fromJson(json['service'] as Map<String, dynamic>),
      branch: BranchInfo.fromJson(json['branch'] as Map<String, dynamic>),
      counter: json['counter'] == null
          ? null
          : CounterInfo.fromJson(json['counter'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      calledAt: json['calledAt'] == null
          ? null
          : DateTime.parse(json['calledAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$TicketModelImplToJson(_$TicketModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'number': instance.number,
      'status': _$TicketStatusEnumMap[instance.status]!,
      'position': instance.position,
      'estimatedWaitMin': instance.estimatedWaitMin,
      'waitDurationSec': instance.waitDurationSec,
      'serviceDurationSec': instance.serviceDurationSec,
      'notes': instance.notes,
      'queue': instance.queue,
      'service': instance.service,
      'branch': instance.branch,
      'counter': instance.counter,
      'createdAt': instance.createdAt.toIso8601String(),
      'calledAt': instance.calledAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

const _$TicketStatusEnumMap = {
  TicketStatus.waiting: 'waiting',
  TicketStatus.called: 'called',
  TicketStatus.inService: 'inService',
  TicketStatus.completed: 'completed',
  TicketStatus.cancelled: 'cancelled',
  TicketStatus.missed: 'missed',
  TicketStatus.transferred: 'transferred',
  TicketStatus.expired: 'expired',
};
