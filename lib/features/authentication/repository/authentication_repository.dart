import 'dart:async';

import 'package:backsystem_desktop_app/core/utils/auth.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  String? _token;

  String? get token => _token;
  Stream<AuthenticationStatus> get status async* {
    final token = getToken();
    print('token: $token');
    yield token == null || token.isEmpty ? AuthenticationStatus.unauthenticated : AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<dynamic> getCaptchaData() async {
    final res = await GetIt.I.get<Dio>().get('/captchaImage');
    return res.data;
  }

  Future<void> logIn({
    required String username,
    required String password,
    required String code,
    required String uuid,
  }) async {
    final res = await GetIt.I.get<Dio>().post('/login', data: { 'username': username, 'password': password, 'code': code, 'uuid': uuid });
    setToken(res.data['token']);
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    removeToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}