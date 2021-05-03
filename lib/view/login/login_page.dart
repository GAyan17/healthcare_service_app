import 'package:auth_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  static Page page() => MaterialPage<void>(child: LoginPage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome User'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocProvider(
                create: (_) => LoginCubit(context.read<AuthRepository>()),
                child: LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
