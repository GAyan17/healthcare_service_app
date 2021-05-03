// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthCareServicePartner _$HealthCareServicePartnerFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return HealthCareServicePartner(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    organization: json['organization'] as String,
    provideEmergencyServices: json['provide_emergency_services'] as bool,
    serviceTimeStart: json['service_time_start'] as String,
    serviceTimeEnd: json['service_time_end'] as String,
    serviceDays: json['service_days'] as String,
    avgRating: (json['avg_rating'] as num?)?.toDouble(),
    oneStarRatings: json['one_star_ratings'] as int?,
    twoStarRatings: json['two_star_ratings'] as int?,
    threeStarRatings: json['three_star_ratings'] as int?,
    fourStarRatings: json['four_star_ratings'] as int?,
    fiveStarRatings: json['five_star_ratings'] as int?,
  );
}

Map<String, dynamic> _$HealthCareServicePartnerToJson(
        HealthCareServicePartner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'organization': instance.organization,
      'provide_emergency_services': instance.provideEmergencyServices,
      'service_time_start': instance.serviceTimeStart,
      'service_time_end': instance.serviceTimeEnd,
      'service_days': instance.serviceDays,
      'avg_rating': instance.avgRating,
      'one_star_ratings': instance.oneStarRatings,
      'two_star_ratings': instance.twoStarRatings,
      'three_star_ratings': instance.threeStarRatings,
      'four_star_ratings': instance.fourStarRatings,
      'five_star_ratings': instance.fiveStarRatings,
    };
