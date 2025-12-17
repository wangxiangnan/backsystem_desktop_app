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
                  final res = await GetIt.I<Dio>().request('/api/members/v1/app/buyer/dic_document_type', options: Options(method: 'POST'));
                  print(res);
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