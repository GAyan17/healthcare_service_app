import 'package:appointment_repository/appointment_repository.dart';
import 'package:auth_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare_service_app/view/appoinment/book_appointment_page.dart';
import 'package:healthcare_service_app/view/partner/partner_page.dart';
import 'package:healthcare_service_app/view/view.dart';
import 'package:partner_repository/partner_repository.dart';

import 'bloc/app/app_bloc.dart';
import 'cubit/cubit.dart';

class App extends StatelessWidget {
  const App({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (_) => PartnerRepository(),
            ),
            RepositoryProvider(
              create: (context) => AppointmentRepository(),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AppointmentCubit>(
                create: (context) => AppointmentCubit(
                  context.read<AppointmentRepository>(),
                  context.read<AppBloc>().state.user,
                ),
              ),
              BlocProvider<PartnerCubit>(
                create: (context) =>
                    PartnerCubit(context.read<PartnerRepository>()),
              ),
            ],
            child: AppView(),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) =>
            context.read<AppBloc>().state.status == AppStatus.authenticated
                ? HomePage()
                : LoginPage(),
        SignUpPage.routeName: (_) => SignUpPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            gapPadding: 2.0,
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system,
      // home: FlowBuilder<AppStatus>(
      //   state: context.select((AppBloc bloc) => bloc.state.status),
      //   onGeneratePages: onGenerateAppViewPages,
      // ),
    );
  }
}
