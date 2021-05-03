import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/view/home/partner_search.dart';

import '../../bloc/app/app_bloc.dart';
import '../../cubit/cubit.dart';
import 'appointment_list.dart';
import 'partner_list.dart';
import 'pending_payment_list.dart';
import 'pending_feedback.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) {
      if (bloc.state is Authenticated) {
        return (bloc.state as Authenticated).user;
      }
    });
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is PendingPaymentAppointments) {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Pending Payments!'),
                content: Text('Please Pay pending amount before continuing'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text('Ok'))
                ],
              );
            },
          );
        } else if (state is PendingFeedbacks) {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Pending Feedbacks!'),
                content: Text('Please Give the Feedback'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text('Ok'))
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is PendingPaymentAppointments) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcome, ${user!.name}'),
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
        } else if (state is PendingFeedbacks) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcome, ${user!.name}'),
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
            body: PendingFeedbackList(),
          );
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Welcome, ${user!.name}'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: HealthcCareServicePartnerSearch(),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
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
