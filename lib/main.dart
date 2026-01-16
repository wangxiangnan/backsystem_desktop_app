import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:backsystem_desktop_app/core/config/config.dart';
import 'package:backsystem_desktop_app/core/utils/utils.dart';
import 'app.dart';

void main() async {
  final getIt = GetIt.instance;
  Hive.init('main');
  await Hive.openBox('main');
  getIt.registerSingleton<AppConfig>(await AppConfig.load());
  getIt.registerSingleton<Dio>(dio);
  runApp(App());
}
