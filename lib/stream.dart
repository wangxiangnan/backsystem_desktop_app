import 'dart:async';

void main() async {
  /* final authenticationRepository = AuthenticationRepository();
  authenticationRepository.status.listen(
    (AuthenticationStatus status) {
      print('listen: $status');
    }
  );
  await authenticationRepository.logIn();
  authenticationRepository.logOut(); */
  final stream = timedCounter(Duration(seconds: 1), 20);
  stream.listen(print);
}

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn() async {
    await Future<void>.delayed(Duration(seconds: 30));
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    await Future<void>.delayed(Duration(seconds: 5));
    _controller.add(AuthenticationStatus.unauthenticated);
  }
}

Stream<int> timedCounter(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}