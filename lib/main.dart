import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:backsystem_desktop_app/core/core.dart';
import 'app_view.dart';

void main() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<AppConfig>(await AppConfig.load());
  getIt.registerSingleton<Dio>(dio);
  runApp(AppView());
}
