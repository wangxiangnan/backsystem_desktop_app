
import 'dart:convert';

import 'package:backsystem_desktop_app/core/utils/auth.dart';
import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
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
    validateStatus: (status) {
      return status == 200;
    },
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
      final res = response.data is String ? jsonDecode(response.data) : response.data;
      // print(res);
      if (res['code'] == 401 || res['code'] == 501) {
        GetIt.I.get<AuthenticationRepository>().logOut();
        return handler.reject(DioException.badCertificate(requestOptions: response.requestOptions));
      }
      if (res['code'] != 200) {
        return handler.reject(DioException.badResponse(requestOptions: response.requestOptions.copyWith(), statusCode: res['code'], response: response), true);
      }
      handler.next(
        Response(
          requestOptions: response.requestOptions,
          data: res,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
        )
      );
    },
  )
);
