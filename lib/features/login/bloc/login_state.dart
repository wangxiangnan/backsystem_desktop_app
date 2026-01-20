part of 'login_bloc.dart';

// data username, password, 
final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.code = const Code.pure(),
    this.captchaImg = '',
    this.uuid = '',
    this.setting = const Setting(),
    this.isValid = false,
  });

  final Username username;
  final Password password;
  final Code code;
  final String uuid;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String captchaImg;
  final Setting setting;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    Code? code,
    bool? isValid,
    String? uuid,
    String? captchaImg,
    Setting? setting,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      code: code ?? this.code,
      uuid: uuid ?? this.uuid,
      captchaImg: captchaImg ?? this.captchaImg,
      setting: setting ?? this.setting,
    );
  }

  @override
  List<Object> get props => [status, username, password, code, uuid, setting];
}