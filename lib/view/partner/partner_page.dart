import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/cubit/cubit.dart';
import 'package:healthcare_service_app/view/appoinment/book_appointment_page.dart';
import 'package:partner_repository/partner_repository.dart';

class PartnerPage extends StatelessWidget {
  final HealthCareServicePartner partner;

  const PartnerPage({Key? key, required this.partner}) : super(key: key);

  static const String routeName = '/partner_page';

  static Route route(
      {required PartnerCubit partnerCubit,
      required HealthCareServicePartner partner}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: partnerCubit,
        child: PartnerPage(partner: partner),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partner ${partner.name}'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            partner.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 10.0),
          Text(
            partner.organization,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10.0),
          Text('Service Starts: ${partner.serviceTimeStart}'),
          const SizedBox(height: 10.0),
          Text('Service Ends: ${partner.serviceTimeEnd}'),
          const SizedBox(height: 10.0),
          Text('Service Days: ${partner.serviceDays}'),
          const SizedBox(height: 10.0),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BookAppointment(partner: partner),
              )),
              style: TextButton.styleFrom(
                  elevation: 2.5,
                  backgroundColor: Colors.blue,
                  fixedSize: Size.fromWidth(MediaQuery.of(context).size.width)),
              child: Text('Book Appointment'),
            ),
          ),
        ],
      ),
    );
  }
}
