// lib/features/home/data/home_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_models.freezed.dart';
part 'home_models.g.dart';

@freezed
class ServiceSummary with _$ServiceSummary {
  const factory ServiceSummary({
    required String id, required String name, String? icon, String? color,
    int? waitingCount, int? avgWaitMin,
  }) = _ServiceSummary;
  factory ServiceSummary.fromJson(Map<String, dynamic> json) => _$ServiceSummaryFromJson(json);
}

@freezed
class QueueSummary with _$QueueSummary {
  const factory QueueSummary({
    required String id, required String name,
    required String status, int? waitingCount, int? avgWaitMin,
    required ServiceSummary service,
  }) = _QueueSummary;
  factory QueueSummary.fromJson(Map<String, dynamic> json) => _$QueueSummaryFromJson(json);
}

@freezed
class BranchDetail with _$BranchDetail {
  const factory BranchDetail({
    required String id, required String name,
    required String address, required String city,
    String? phone, double? latitude, double? longitude,
    @Default(false) bool openNow, String? openUntil,
    @Default([]) List<QueueSummary> queues,
  }) = _BranchDetail;
  factory BranchDetail.fromJson(Map<String, dynamic> json) => _$BranchDetailFromJson(json);
}

@freezed
class BranchSummary with _$BranchSummary {
  const factory BranchSummary({
    required String id, required String name,
    required String city,
    @Default(false) bool openNow,
    double? distance,
  }) = _BranchSummary;
  factory BranchSummary.fromJson(Map<String, dynamic> json) => _$BranchSummaryFromJson(json);
}

@freezed
class OrganizationCard with _$OrganizationCard {
  const factory OrganizationCard({
    required String id, required String name, required String type,
    String? logoUrl, String? city, String? slug,
    @Default([]) List<BranchSummary> branches,
  }) = _OrganizationCard;
  factory OrganizationCard.fromJson(Map<String, dynamic> json) => _$OrganizationCardFromJson(json);
}