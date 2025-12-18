import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
                  final res = await GetIt.I<Dio>().request('/api/ticket/v1/auth/performance/infoMain/listPage', options: Options(method: 'POST'), data: {'pageNum': 1, 'pageSize': 2, 'createDeptIds': [227]});
                  print('hello $res.');
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