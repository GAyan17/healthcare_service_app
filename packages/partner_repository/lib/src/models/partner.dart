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
  final double? avgRating;
  final int? oneStarRatings;
  final int? twoStarRatings;
  final int? threeStarRatings;
  final int? fourStarRatings;
  final int? fiveStarRatings;

  const HealthCareServicePartner({
    required this.id,
    required this.email,
    required this.name,
    required this.organization,
    required this.provideEmergencyServices,
    required this.serviceTimeStart,
    required this.serviceTimeEnd,
    required this.serviceDays,
    this.avgRating,
    this.oneStarRatings,
    this.twoStarRatings,
    this.threeStarRatings,
    this.fourStarRatings,
    this.fiveStarRatings,
  });

  factory HealthCareServicePartner.fromJson(Map<String, dynamic> json) =>
      _$HealthCareServicePartnerFromJson(json);

  Map<String, dynamic> toJson() => _$HealthCareServicePartnerToJson(this);

  HealthCareServicePartner copyWith({
    String? id,
    String? email,
    String? name,
    String? organization,
    bool? provideEmergencyServices,
    String? serviceTimeStart,
    String? serviceTimeEnd,
    String? serviceDays,
    double? avgRating,
    int? oneStarRatings,
    int? twoStarRatings,
    int? threeStarRatings,
    int? fourStarRatings,
    int? fiveStarRatings,
  }) {
    return HealthCareServicePartner(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      provideEmergencyServices:
          provideEmergencyServices ?? this.provideEmergencyServices,
      serviceTimeStart: serviceTimeStart ?? this.serviceTimeStart,
      serviceTimeEnd: serviceTimeEnd ?? this.serviceTimeEnd,
      serviceDays: serviceDays ?? this.serviceDays,
      avgRating: avgRating ?? this.avgRating,
      oneStarRatings: oneStarRatings ?? this.oneStarRatings,
      twoStarRatings: twoStarRatings ?? this.twoStarRatings,
      threeStarRatings: threeStarRatings ?? this.threeStarRatings,
      fourStarRatings: fourStarRatings ?? this.fourStarRatings,
      fiveStarRatings: fiveStarRatings ?? this.fiveStarRatings,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        organization,
        provideEmergencyServices,
        serviceTimeStart,
        serviceTimeEnd,
        serviceDays,
        avgRating,
        oneStarRatings,
        twoStarRatings,
        threeStarRatings,
        fourStarRatings,
        fiveStarRatings,
      ];
}
