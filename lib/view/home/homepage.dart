import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/cubit/cubit.dart';
import 'package:partner_repository/partner_repository.dart';

import '../../bloc/app/app_bloc.dart';
import 'partner_list.dart';

class HomePage extends StatelessWidget {
  static Page page() => MaterialPage<void>(
        child: RepositoryProvider(
          create: (_) => PartnerRepository(),
          child: HomePage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
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
        ),
        body: BlocProvider(
          create: (context) => PartnerCubit(context.read<PartnerRepository>()),
          child: PartnerList(),
        ));
  }
}
