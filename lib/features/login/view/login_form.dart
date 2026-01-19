
import 'dart:convert';

import 'package:formz/formz.dart';

import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({ super.key });

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>().add(LoginCaptchaClicked());
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1/3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12),),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12),),
            _CodeInput(),
            const Padding(padding: EdgeInsets.all(12),),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.username.displayError
    );

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username));
      },
      decoration: InputDecoration(
        labelText: 'username',
        errorText: displayError != null ? 'invalid username' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((LoginBloc bloc) => bloc.state.password.displayError);
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((LoginBloc bloc) => bloc.state.code.displayError);
    final codeImg = context.select((LoginBloc bloc) => bloc.state.captchaImg);
    return Row(
      spacing: 20,
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            key: const Key('loginForm_codeInput_textField'),
            onChanged: (value) {
              context.read<LoginBloc>().add(LoginCodeChanged(value));
            },
            decoration: InputDecoration(
              labelText: 'code',
              errorText: displayError != null ? 'invalid code' : null,
            ),
          ),
        ),
        SizedBox(
          width: 120,
          height: 60,
          child: GestureDetector(
            onTap: () {
              context.read<LoginBloc>().add(LoginCaptchaClicked());
            },
            child: codeImg.isNotEmpty ? Image.memory(
              base64Decode(codeImg),
              fit: BoxFit.cover,
            ) : null,
          ),
        )
        
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      onPressed: isValid ? () => context.read<LoginBloc>().add(const LoginSubmitted()) : null,
      child: const Text('Login'),
    );
  }
}
