
import 'dart:convert';

import 'package:formz/formz.dart';

import '../bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ super.key });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(LoginCaptchaClicked());
    context.read<LoginBloc>().add(LoginSettingFetch());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select<LoginBloc, LoginState>((bloc) => bloc.state);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('登录失败！')),
            );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: state.setting.bgImgUrl.isNotEmpty ? DecorationImage(
            image: NetworkImage(state.setting.bgImgUrl),
            fit: BoxFit.cover,
          ) : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
                child: Image.network(
                  'https://res.dasheng.top/ctms_log/log_two_bg.png',
                  width: 836,
                ),
              ),
              _Form(),
            ],
          ),
        )
      ),
    );
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 463,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(50, 76, 50, 76),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('👏 Hi，欢迎登录～'),
          const Padding(padding: EdgeInsets.all(6),),
          const Text('看个比赛票务管理平台', style: TextStyle(color: Color(0xff16181d), fontSize: 34)),
          /*<p class="hi_p_style"></p>
<h3 class="title" style="text-align: left; color: #16181d">
看个比赛票务管理平台
</h3>*/   const Padding(padding: EdgeInsets.all(33),),
          _UsernameInput(),
          const Padding(padding: EdgeInsets.all(12),),
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12),),
          _CodeInput(),
          const Padding(padding: EdgeInsets.all(28),),
          _LoginButton(),
        ],
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
        labelText: '账号',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1)
        ),
        errorText: displayError != null ? '请输入您的账号' : null,
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
        labelText: '密码',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1)
        ),
        errorText: displayError != null ? '请输入您的密码' : null,
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
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            key: const Key('loginForm_codeInput_textField'),
            onChanged: (value) {
              context.read<LoginBloc>().add(LoginCodeChanged(value));
            },
            decoration: InputDecoration(
              
              labelText: '验证码',
              prefixIcon: Icon(Icons.verified_user),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1)
              ),
              errorText: displayError != null ? '请输入您的验证码' : null,
            ),
          ),
        ),
        SizedBox(
          width: 120,
          height: 48,
          child: GestureDetector(
            onTap: () {
              context.read<LoginBloc>().add(LoginCaptchaClicked());
            },
            child: codeImg.isNotEmpty ? Image.memory(
              base64Decode(codeImg),
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

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 56)),
        ),
        onPressed: isValid && !isInProgressOrSuccess ? () => context.read<LoginBloc>().add(const LoginSubmitted()) : null,
        child: isInProgressOrSuccess ? const CircularProgressIndicator() : const Text('登录', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      );
  }
}
