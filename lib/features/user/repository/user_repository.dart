import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    final res = await GetIt.I.get<Dio>().get<Map<String, dynamic>>(
      '/getInfo',
    );
    print('user-repository-res: $res');
    final data = res.data;
    if (data != null) {
      _user = User.fromJson(data);
    }
    return _user;
  }
}