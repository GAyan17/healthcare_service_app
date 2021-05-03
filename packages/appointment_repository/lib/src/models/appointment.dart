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
  final double? rating;

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
    this.rating,
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
        rating,
      ];

  Appointment copyWith({
    String? id,
    String? partnerId,
    String? partnerName,
    String? patientName,
    String? patientId,
    int? patientAge,
    DateTime? appointmentDateTime,
    String? symptoms,
    String? description,
    String? prescription,
    String? appointmentStatus,
    String? paymentStatus,
    double? rating,
  }) {
    return Appointment(
      id: id ?? this.id,
      partnerId: partnerId ?? this.partnerId,
      partnerName: partnerName ?? this.partnerName,
      patientName: patientName ?? this.patientName,
      patientId: patientId ?? this.patientId,
      patientAge: patientAge ?? this.patientAge,
      appointmentDateTime: appointmentDateTime ?? this.appointmentDateTime,
      symptoms: symptoms ?? this.symptoms,
      description: description ?? this.description,
      prescription: prescription ?? this.prescription,
      appointmentStatus: appointmentStatus ?? this.appointmentStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      rating: rating ?? this.rating,
    );
  }
}
