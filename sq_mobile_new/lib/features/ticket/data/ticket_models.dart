// lib/features/ticket/data/ticket_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_models.freezed.dart';
part 'ticket_models.g.dart';

enum TicketStatus {
  waiting, called, inService, completed, cancelled, missed, transferred, expired;

  String get label => switch (this) {
    TicketStatus.waiting     => 'En attente',
    TicketStatus.called      => 'Appelé',
    TicketStatus.inService   => 'En service',
    TicketStatus.completed   => 'Terminé',
    TicketStatus.cancelled   => 'Annulé',
    TicketStatus.missed      => 'Manqué',
    TicketStatus.transferred => 'Transféré',
    TicketStatus.expired     => 'Expiré',
  };

  bool get isActive =>
      this == waiting || this == called || this == inService;
}

@freezed
class QueueInfo with _$QueueInfo {
  const factory QueueInfo({
    required String id,
    required String name,
    required String prefix,
    int? waitingCount,
  }) = _QueueInfo;
  factory QueueInfo.fromJson(Map<String, dynamic> json) =>
      _$QueueInfoFromJson(json);
}

@freezed
class ServiceInfo with _$ServiceInfo {
  const factory ServiceInfo({
    required String id,
    required String name,
    String? icon,
    String? color,
  }) = _ServiceInfo;
  factory ServiceInfo.fromJson(Map<String, dynamic> json) =>
      _$ServiceInfoFromJson(json);
}

@freezed
class BranchInfo with _$BranchInfo {
  const factory BranchInfo({
    required String id,
    required String name,
    required String address,
    String? city,
  }) = _BranchInfo;
  factory BranchInfo.fromJson(Map<String, dynamic> json) =>
      _$BranchInfoFromJson(json);
}

@freezed
class CounterInfo with _$CounterInfo {
  const factory CounterInfo({
    required String id,
    required String name,
    required int number,
  }) = _CounterInfo;
  factory CounterInfo.fromJson(Map<String, dynamic> json) =>
      _$CounterInfoFromJson(json);
}

@freezed
class TicketModel with _$TicketModel {
  const factory TicketModel({
    required String id,
    required String code,
    required int number,
    required TicketStatus status,
    int? position,
    int? estimatedWaitMin,
    int? waitDurationSec,
    int? serviceDurationSec,
    String? notes,
    required QueueInfo queue,
    required ServiceInfo service,
    required BranchInfo branch,
    CounterInfo? counter,
    required DateTime createdAt,
    DateTime? calledAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    DateTime? expiresAt,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
}

// DTO séparé — PAS Freezed, classe simple avec toJson() manuel
class CreateTicketDto {
  const CreateTicketDto({
    required this.queueId,
    required this.branchId,
    required this.serviceId,
  });

  final String queueId;
  final String branchId;
  final String serviceId;

  Map<String, dynamic> toJson() => {
    'queueId':   queueId,
    'branchId':  branchId,
    'serviceId': serviceId,
  };
}
