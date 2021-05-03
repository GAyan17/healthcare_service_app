part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentsRecieved extends AppointmentState {
  final List<Appointment> appointments;

  const AppointmentsRecieved(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class PendingPaymentAppointments extends AppointmentState {
  final List<Appointment> appointments;

  const PendingPaymentAppointments(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class PendingFeedbacks extends AppointmentState {
  final List<Appointment> appointments;

  const PendingFeedbacks(this.appointments);

  @override
  List<Object> get props => [appointments];
}
