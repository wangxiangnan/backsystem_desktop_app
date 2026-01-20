import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
    required LoginRepository loginRepository,
  }) : _authenticationRepository = authenticationRepository,
      _loginRepository = loginRepository,
  super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginCodeChanged>(_onCodeChanged);
    on<LoginCaptchaClicked>(_loginCaptchaClicked);
    on<LoginSettingFetch>(_loginSettingFetch);
  }

  final AuthenticationRepository _authenticationRepository;
  final LoginRepository _loginRepository;

  void _onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username, state.code]),
      ),
    );
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.username, state.code]),
      ),
    );
  }

  void _onCodeChanged(LoginCodeChanged event, Emitter<LoginState> emit) {
    final code = Code.dirty(event.code);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate([code, state.username, state.password]),
      )
    );
  }

  void _loginCaptchaClicked(LoginCaptchaClicked event, Emitter<LoginState> emit) async {
    final res = await _authenticationRepository.getCaptchaData();
    emit(
      state.copyWith(
        uuid: res['uuid'],
        captchaImg: res['img'],
      ),
    );
  }

  void _loginSettingFetch(LoginSettingFetch event, Emitter<LoginState> emit) async {
    final setting = await _loginRepository.getSetting();
    emit(
      state.copyWith(
        setting: setting,
      ),
    );
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
          code: state.code.value,
          uuid: state.uuid,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (err) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}