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
  );
}

Map<String, dynamic> _$HealthCareServicePartnerToJson(
        HealthCareServicePartner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'organization': instance.organization,
    };
