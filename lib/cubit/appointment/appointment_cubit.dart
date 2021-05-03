import 'dart:async';

import 'package:appointment_repository/appointment_repository.dart';
import 'package:auth_repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this._appointmentRepository, this.patientUser)
      : super(AppointmentInitial()) {
    _appointmentSubscription = _appointmentRepository
        .getAppointments(patientUser.id)
        .listen(_onAppointmentsRecieved);
  }

  final User patientUser;
  final AppointmentRepository _appointmentRepository;
  late final StreamSubscription _appointmentSubscription;

  void _onAppointmentsRecieved(List<Appointment> appointments) {
    var pendingPayments = appointments.where((appointment) {
      return appointment.appointmentStatus == 'Done' &&
          appointment.paymentStatus == 'Pending';
    }).toList();
    if (pendingPayments.isNotEmpty) {
      emit(PendingPaymentAppointments(pendingPayments));
    } else {
      emit(AppointmentsRecieved(appointments));
    }
  }

  Future<void> createAppointment({
    required String partnerId,
    required String partnerName,
    required String symptoms,
    String? description,
  }) async {
    final appointment = Appointment(
        partnerId: partnerId,
        partnerName: partnerName,
        patientId: patientUser.id,
        patientName: patientUser.name,
        patientAge: calculateAge(patientUser.dob!),
        symptoms: symptoms,
        description: description,
        appointmentStatus: 'Pending',
        paymentStatus: 'Pending');
    await _appointmentRepository.createAppointment(appointment);
  }

  int calculateAge(DateTime dob) {
    return DateTime.now().year - dob.year;
  }

  @override
  Future<void> close() {
    _appointmentSubscription.cancel();
    return super.close();
  }

  Future<void> paymentDone({required Appointment appointment}) async {
    await _appointmentRepository
        .updateAppointment(appointment.copyWith(paymentStatus: 'Done'));
  }

  Future<void> addRating(
      {required Appointment appointment, required double rating}) async {
    await _appointmentRepository
        .updateAppointment(appointment.copyWith(rating: rating));
  }
}
