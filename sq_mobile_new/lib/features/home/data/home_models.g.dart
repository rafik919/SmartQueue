// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceSummaryImpl _$$ServiceSummaryImplFromJson(Map<String, dynamic> json) =>
    _$ServiceSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      waitingCount: (json['waitingCount'] as num?)?.toInt(),
      avgWaitMin: (json['avgWaitMin'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ServiceSummaryImplToJson(
        _$ServiceSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'waitingCount': instance.waitingCount,
      'avgWaitMin': instance.avgWaitMin,
    };

_$QueueSummaryImpl _$$QueueSummaryImplFromJson(Map<String, dynamic> json) =>
    _$QueueSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      waitingCount: (json['waitingCount'] as num?)?.toInt(),
      avgWaitMin: (json['avgWaitMin'] as num?)?.toInt(),
      service: ServiceSummary.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$QueueSummaryImplToJson(_$QueueSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'waitingCount': instance.waitingCount,
      'avgWaitMin': instance.avgWaitMin,
      'service': instance.service,
    };

_$BranchDetailImpl _$$BranchDetailImplFromJson(Map<String, dynamic> json) =>
    _$BranchDetailImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      phone: json['phone'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      openNow: json['openNow'] as bool? ?? false,
      openUntil: json['openUntil'] as String?,
      queues: (json['queues'] as List<dynamic>?)
              ?.map((e) => QueueSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BranchDetailImplToJson(_$BranchDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'openNow': instance.openNow,
      'openUntil': instance.openUntil,
      'queues': instance.queues,
    };

_$BranchSummaryImpl _$$BranchSummaryImplFromJson(Map<String, dynamic> json) =>
    _$BranchSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      openNow: json['openNow'] as bool? ?? false,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$BranchSummaryImplToJson(_$BranchSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'openNow': instance.openNow,
      'distance': instance.distance,
    };

_$OrganizationCardImpl _$$OrganizationCardImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationCardImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      logoUrl: json['logoUrl'] as String?,
      city: json['city'] as String?,
      slug: json['slug'] as String?,
      branches: (json['branches'] as List<dynamic>?)
              ?.map((e) => BranchSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrganizationCardImplToJson(
        _$OrganizationCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'logoUrl': instance.logoUrl,
      'city': instance.city,
      'slug': instance.slug,
      'branches': instance.branches,
    };
