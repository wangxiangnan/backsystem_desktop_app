import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({ super.key });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Greeting(),
            _LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogOutPressed());
      },
      child: const Text('退出登录'),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    final nickName = context.select<AuthenticationBloc, String>(
      (AuthenticationBloc bloc) => bloc.state.user.nickName,
    );

    return Text('👏欢迎 $nickName 登录!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),);
  }
}
