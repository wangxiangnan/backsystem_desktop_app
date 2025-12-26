import 'dart:io';

import 'package:backsystem_desktop_app/core/config/app_config.dart';
import 'package:dio/dio.dart';
import 'sign.dart';
import 'package:get_it/get_it.dart';

final dio = Dio(
  BaseOptions(
    sendTimeout: Duration(
      seconds: 10,
    ),
    connectTimeout: Duration(
      seconds: 20,
    ),
    receiveTimeout: Duration(
      seconds: 10
    ),
    baseUrl: GetIt.I.get<AppConfig>().apiBaseUrl,
    method: 'POST',
  )
)..interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      final sign = getSign(options.data);
      final newOptions = options.copyWith(
        headers: {
          ...options.headers,
          'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJsb2dpbl91c2VyX2tleSI6Ijg2YzlkNDMwLWIyMzgtNGUwNi05MDlkLTI5ZmMyNTQyZmUzYyJ9.geiZ8QOWTp_Feuy4LtlSqjzg2l6JO1s56VkEa6RrtHXqPsOReT1bOXL6_vzMKUtlFhCWSIo129pAzejescAilw',
          'sign': sign
        }
      );
      handler.next(newOptions);
    },
    onResponse: (res, handler) {
      final data = res.data;
      if (data['code'] == 401) {
        return handler.reject(DioException.badCertificate(requestOptions: res.requestOptions));
      }
      if (data['code'] != 200) {
        return handler.reject(DioException.badResponse(requestOptions: res.requestOptions, statusCode: data['code'], response: res),);
      }
      handler.next(Response(requestOptions: res.requestOptions, data: res.data));
    },
  )
);
