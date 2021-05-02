import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/app_bloc.dart';
import '../../cubit/cubit.dart';
import 'appointment_list.dart';
import 'partner_list.dart';
import 'pending_payment_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is PendingPaymentAppointments) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcome, ${user.name}'),
              actions: <Widget>[
                IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    context.read<AppBloc>().add(AppLogOutRequested());
                  },
                )
              ],
            ),
            body: PendingPaymentList(),
          );
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Welcome, ${user.name}'),
              actions: <Widget>[
                IconButton(
                  key: const Key('homePage_logout_iconButton'),
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () =>
                      context.read<AppBloc>().add(AppLogOutRequested()),
                )
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: const Icon(Icons.book_rounded),
                    child: const Text('Partners'),
                  ),
                  Tab(
                    icon: const Icon(Icons.timelapse),
                    child: const Text('My Appointments'),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                PartnerList(),
                AppointmentList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
