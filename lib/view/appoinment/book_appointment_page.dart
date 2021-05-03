import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/cubit/cubit.dart';
import 'package:partner_repository/partner_repository.dart';

class BookAppointment extends StatefulWidget {
  final HealthCareServicePartner partner;

  const BookAppointment({Key? key, required this.partner}) : super(key: key);

  static const String routeName = '/book_appointment';

  static Route route({required HealthCareServicePartner partner}) {
    return MaterialPageRoute(
      builder: (_) {
        return BookAppointment(
          partner: partner,
        );
      },
    );
  }

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _symptomController;
  late TextEditingController _descriptionController;

  bool _tapped = false;

  @override
  void initState() {
    super.initState();
    _symptomController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _symptomController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 8.0),
              TextFormField(
                controller: _symptomController,
                decoration: InputDecoration(labelText: 'Symptoms'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter symptoms';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 5,
                validator: (value) => null,
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                  onPressed: !_tapped
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            _tapped = true;

                            print(_symptomController.text);
                            print(_descriptionController.text);

                            await context
                                .read<AppointmentCubit>()
                                .createAppointment(
                                    partnerId: widget.partner.id,
                                    partnerName: widget.partner.name,
                                    symptoms: _symptomController.text,
                                    description: _descriptionController.text);
                            Navigator.of(context).popUntil((route) {
                              return route.isFirst;
                            });
                          }
                        }
                      : null,
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
