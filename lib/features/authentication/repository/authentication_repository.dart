import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }
  Future<String> logIn({
    required String username,
    required String password,
    required String code,
    required String uuid,
  }) async {
    final res = await GetIt.I.get<Dio>().post<Map<String, String>>('/login', data: { 'username': username, 'password': password, 'code': code, 'uuid': uuid });
    _controller.add(AuthenticationStatus.authenticated);
    return res;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}