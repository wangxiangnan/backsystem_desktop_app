import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:backsystem_desktop_app/features/features.dart';

class AppView extends StatelessWidget {
  const AppView({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('hello'),
              ElevatedButton(
                onPressed: () async {
                  final auth = AuthenticationRepository();
                  await auth.logIn(username: 'xcxAdmin', password: 'Wag@2024', code: '0', uuid: 'bc4ab8dbd73e4e17b39eafca7967c880');
                },
                child: const Text('获取icon')
              ),
            ],
          ),
        ),
      ),
    );
  }
}