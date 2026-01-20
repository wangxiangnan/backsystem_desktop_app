import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/setting.dart';

class LoginRepository {
  Setting? setting;

  Future<Setting?> getSetting() async {
    var copyrightText = '';
    var bgImgUrl = '';
    final res = await GetIt.I.get<Dio>().post('/api/cms/v1/auth/cms/other/loginUrl');
    for (final item in res.data['data']) {
      if (item['keyNum'] == 'ctms.cms.common.conf.10105') {
        bgImgUrl = item['keyValue'];
      } else if (item['keyNum'] == 'ctms.cms.common.conf.10106') {
        copyrightText = item['keyValue'];
      }
    }
    setting = Setting(copyrightText: copyrightText, bgImgUrl: bgImgUrl);
    return setting;
  }

}