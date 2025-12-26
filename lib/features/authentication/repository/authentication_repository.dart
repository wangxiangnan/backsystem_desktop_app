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
    
  }
  Future<void> logIn({
    required String username,
    required String password,
    required String code,
    required String uuid,
  }) async {
    final res = await GetIt.I.get<Dio>().post('/login', data: { 'username': username, 'password': password, 'code': code, 'uuid': uuid });
    print('res: $res');
    _controller.add(AuthenticationStatus.authenticated);
  }
}