import 'dart:convert';

import 'package:crypto/crypto.dart';

const salt = 'ctms';

String getSign(dynamic data) {
  var sign = '';
  if (data is Map) {
    final map = mapSort(data);
    final str = '${jsonEncode(map)}$salt';
    sign = md5.convert(utf8.encode(str)).toString();
  }

  return sign;
}

Map mapSort(Map map) {
  final newMap = <String, Object>{};
  List<String> keys = map.keys.map((dynamic key) => key.toString()).toList()..sort((a, b) => a.compareTo(b));
  for (final key in keys) {
    final value = map[key];
    if (value is Map) {
      newMap[key] = mapSort(value);
    } else if (value is List) {
      newMap[key] = value.map((item) {
        if (item is Map) {
          return mapSort(item);
        }
        return item;
      }).toList();
    } else {
      newMap[key] = value;
    }
  }
  return newMap;
}