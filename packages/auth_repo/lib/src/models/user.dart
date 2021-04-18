import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(required: true)
  final String id;
  final String? email;
  final String? name;
  final String? photo;
  final DateTime? dob;

  const User(
      {required this.id,
      required this.email,
      required this.name,
      this.dob,
      this.photo});

  User copyWith({String? name, int? age, DateTime? dob, String? photo}) {
    return User(
        id: id,
        email: email,
        name: name ?? this.name,
        dob: dob ?? this.dob,
        photo: photo ?? this.photo);
  }

  static const nouser = User(id: '', email: '', name: '');

  bool get isUser => this == User.nouser;

  bool get isNotUser => this != User.nouser;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [email, id, name, photo, dob];
}
