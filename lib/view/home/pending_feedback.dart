import 'package:appointment_repository/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/cubit/cubit.dart';

class PendingFeedbackList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is PendingFeedbacks) {
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
                        subtitle: _RatingWidget(
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

class _RatingWidget extends StatefulWidget {
  final Appointment appointment;

  const _RatingWidget({Key? key, required this.appointment}) : super(key: key);

  @override
  __RatingWidgetState createState() => __RatingWidgetState();
}

class __RatingWidgetState extends State<_RatingWidget> {
  double _rating = 1.0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add FeedBack'),
      content: Slider(
        label: '$_rating',
        max: 5.0,
        min: 1.0,
        divisions: 4,
        onChanged: (double value) {
          setState(() {
            _rating = value;
          });
        },
        value: _rating,
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              await context.read<PartnerCubit>().updateRating(
                  partnerId: widget.appointment.partnerId!, rating: _rating);

              await context.read<AppointmentCubit>().addRating(
                    appointment: widget.appointment,
                    rating: _rating,
                  );

              Navigator.of(context).pop();
            },
            child: Text('Add'))
      ],
    );
  }
}
