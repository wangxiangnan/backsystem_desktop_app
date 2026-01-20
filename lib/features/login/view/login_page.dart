import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
import '../repository/repository.dart';
import '../view/login_form.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: RepositoryProvider(
          create: (_) => LoginRepository(),
          child: BlocProvider(
            create: (context) => LoginBloc(
              authenticationRepository: context.read<AuthenticationRepository>(),
              loginRepository: context.read<LoginRepository>(),
            ),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}