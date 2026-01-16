
import 'dart:convert';

import 'package:backsystem_desktop_app/core/utils/auth.dart';
import 'package:dio/dio.dart';
import 'sign.dart';
import 'package:get_it/get_it.dart';
import '../config/config.dart';

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
      final token = getToken();
      final sign = getSign(options.data);
      final newOptions = options.copyWith(
        headers: {
          ...options.headers,
          'Authorization': 'Bearer $token',
          'sign': sign
        }
      );
      handler.next(newOptions);
    },
    onResponse: (response, handler) {
      final res = jsonDecode(response.data);

      if (res['code'] == 401) {
        return handler.reject(DioException.badCertificate(requestOptions: res.requestOptions));
      }
      if (res['code'] != 200) {
        return handler.reject(DioException.badResponse(requestOptions: res.requestOptions, statusCode: res['code'], response: res),);
      }
      handler.next(Response(requestOptions: response.requestOptions, data: res['data'] ?? res['token']));
    },
  )
);
