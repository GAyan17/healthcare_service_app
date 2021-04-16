import 'package:flutter/material.dart';

import '../bloc/app/app_bloc.dart';
import '../view/home/homepage.dart';
import '../view/login/login_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
