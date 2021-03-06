import 'package:appointment_repository/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/cubit/cubit.dart';

class PendingPaymentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is PendingPaymentAppointments) {
          return state.appointments.isNotEmpty
              ? ListView.builder(
                  itemCount: state.appointments.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          print('tapped');
                        },
                        title: Row(
                          children: [
                            Text(
                              'Appointment with:',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(state.appointments[index].partnerName!),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'On :',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Text(state.appointments[index].appointmentDateTime
                                .toString())
                          ],
                        ),
                        trailing: _CompletePaymentButton(
                            appointment: state.appointments[index]),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No Appointments'),
                );
        } else {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 10.0),
              const Text('Loading...'),
            ],
          );
        }
      },
    );
  }
}

class _CompletePaymentButton extends StatefulWidget {
  final Appointment appointment;

  const _CompletePaymentButton({Key? key, required this.appointment})
      : super(key: key);

  @override
  __CompletePaymentButtonState createState() => __CompletePaymentButtonState();
}

class __CompletePaymentButtonState extends State<_CompletePaymentButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          print('Complete Payment');
          await context
              .read<AppointmentCubit>()
              .paymentDone(appointment: widget.appointment);
        },
        child: Text('Complete Payment'));
  }
}
