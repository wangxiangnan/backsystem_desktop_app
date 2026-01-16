import 'package:hive/hive.dart';

final box = Hive.box('main');
const tokenKey = 'tokenKey';

String? getToken() {
  return box.get(tokenKey);
}

void setToken(String token) async {
  box.put(tokenKey, token);
}

void removeToken() async {
  box.delete(tokenKey);
}