import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'partner.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HealthCareServicePartner extends Equatable {
  @JsonKey(required: true)
  final String id;
  final String email;
  final String name;
  final String organization;
  final bool provideEmergencyServices;
  final String serviceTimeStart;
  final String serviceTimeEnd;
  final String serviceDays;

  const HealthCareServicePartner({
    required this.id,
    required this.email,
    required this.name,
    required this.organization,
    required this.provideEmergencyServices,
    required this.serviceTimeStart,
    required this.serviceTimeEnd,
    required this.serviceDays,
  });

  factory HealthCareServicePartner.fromJson(Map<String, dynamic> json) =>
      _$HealthCareServicePartnerFromJson(json);

  Map<String, dynamic> toJson() => _$HealthCareServicePartnerToJson(this);

  @override
  List<Object?> get props => [id, email, name, organization];
}
