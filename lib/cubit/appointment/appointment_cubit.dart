import 'dart:async';

import 'package:appointment_repository/appointment_repository.dart';
import 'package:auth_repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthcare_service_app/bloc/bloc.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this._appointmentRepository, this.appBloc)
      : super(AppointmentInitial()) {
    if (appBloc.state is Authenticated) {
      _patientUser = (appBloc.state as Authenticated).user;
      _appointmentSubscription = _appointmentRepository
          .getAppointments(_patientUser.id)
          .listen(_onAppointmentsRecieved);
    }
  }

  final AppBloc appBloc;
  late final User _patientUser;
  final AppointmentRepository _appointmentRepository;
  late final StreamSubscription _appointmentSubscription;

  void _onAppointmentsRecieved(List<Appointment> appointments) {
    var pendingPayments = appointments.where((appointment) {
      return appointment.appointmentStatus == 'Done' &&
          appointment.paymentStatus == 'Pending';
    }).toList();
    var pendingFeedbacks = appointments
        .where((appointment) =>
            appointment.rating == null &&
            appointment.appointmentStatus == 'Done' &&
            appointment.paymentStatus == 'Done')
        .toList();
    if (pendingPayments.isNotEmpty) {
      emit(PendingPaymentAppointments(pendingPayments));
    } else if (pendingFeedbacks.isNotEmpty) {
      emit(PendingFeedbacks(pendingFeedbacks));
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
        id: DateTime.now().millisecondsSinceEpoch.toRadixString(16),
        partnerId: partnerId,
        partnerName: partnerName,
        patientId: _patientUser.id,
        patientName: _patientUser.name,
        patientAge: calculateAge(_patientUser.dob!),
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
