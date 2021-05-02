import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Appointment extends Equatable {
  final String? id;
  final String? partnerId;
  final String? partnerName;
  final String? patientName;
  final String? patientId;
  final int? patientAge;
  final DateTime? appointmentDateTime;
  final String? symptoms;
  final String? description;
  final String? prescription;
  final String? appointmentStatus;
  final String? paymentStatus;

  Appointment({
    this.id,
    required this.partnerId,
    required this.partnerName,
    required this.patientId,
    required this.patientName,
    required this.patientAge,
    this.appointmentDateTime,
    required this.symptoms,
    this.description,
    this.prescription,
    required this.appointmentStatus,
    required this.paymentStatus,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  @override
  List<Object?> get props => [
        id,
        partnerId,
        partnerName,
        patientId,
        patientName,
        patientAge,
        appointmentDateTime,
        symptoms,
        description,
        appointmentStatus,
        paymentStatus,
        prescription,
      ];
}
