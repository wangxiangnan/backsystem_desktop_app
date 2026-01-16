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
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
    required String code,
    required String uuid,
  }) async {
    try {
      final res = await GetIt.I.get<Dio>().post<String>('/login', data: { 'username': username, 'password': password, 'code': code, 'uuid': uuid });
      setToken(res.data!);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      print(e);
    }
    
  }

  void logOut() async {
    removeToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}