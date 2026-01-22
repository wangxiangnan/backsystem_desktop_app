import 'package:backsystem_desktop_app/core/router/router.dart';
import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'app.dart';

void main() async {
  GetIt.I.registerSingleton<GoRouter>(router);
  GetIt.I.registerSingleton<AuthenticationRepository>(AuthenticationRepository());
  runApp(App());
}
