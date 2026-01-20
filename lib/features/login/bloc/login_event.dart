part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginCodeChanged extends LoginEvent {
  const LoginCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class LoginCaptchaClicked extends LoginEvent {
  const LoginCaptchaClicked();
}

final class LoginSettingFetch extends LoginEvent {
  const LoginSettingFetch();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
