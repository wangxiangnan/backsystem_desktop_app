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
      seconds: 10,
    ),
    receiveTimeout: Duration(
      minutes: 2
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
          'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJsb2dpbl91c2VyX2tleSI6IjhhNDFhM2E1LWE4YjMtNGJjYi04NWUzLWVjNWEzZjBmNTI2ZiJ9.mAxebdlYV7XyTZ2QV9VFjcPqHKRMug6JdWMfxfhdng4yJm3P_DOWmf4GsxI0q1smtE9-HSapWemmlJukWmTmyA',
          'sign': sign
        }
      );
      handler.next(newOptions);
    },
    onResponse:(response, handler) {
      handler.next(response);
    },
  )
);
