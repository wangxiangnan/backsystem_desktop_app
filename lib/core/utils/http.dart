import 'package:backsystem_desktop_app/core/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: Duration(
      seconds: 20,
    ),
    receiveTimeout: Duration(
      minutes: 2
    ),
    baseUrl: GetIt.I.get<AppConfig>().apiBaseUrl,
    method: 'POST',
  )
);