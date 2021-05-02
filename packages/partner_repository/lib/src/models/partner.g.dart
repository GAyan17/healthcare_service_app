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
    };
