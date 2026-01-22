import 'package:backsystem_desktop_app/features/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:backsystem_desktop_app/core/config/config.dart';
import 'package:backsystem_desktop_app/core/utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final getIt = GetIt.I;
    // 开始初始化任务
    // 1. 加载本地配置
    // 1.1 加载app配置
    getIt.registerSingleton<AppConfig>(await AppConfig.load());
    // 1.2 初始化键值对工具Hive
    Hive.init('main');
    await Hive.openBox('main');
    // 1.3 加载http
    getIt.registerSingleton<Dio>(dio);
    // 2. 检查用户登录状态
    if (mounted) {
      context.read<AuthenticationRepository>().verifyLoginStatus();
    }
    // 3. 初始化第三方SDK

    // 4. 检查应用更新

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}