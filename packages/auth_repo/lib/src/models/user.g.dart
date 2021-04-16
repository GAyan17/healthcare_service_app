// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return User(
    id: json['id'] as String,
    email: json['email'] as String?,
    name: json['name'] as String?,
    age: json['age'] as int?,
    dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    photo: json['photo'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'age': instance.age,
      'dob': instance.dob?.toIso8601String(),
    };
