import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';
import 'package:dun_cookie_flutter/model/newest_cookie_id_model.dart';

import 'main.dart';

class CdnCookieApi {
  /// 最新饼id
  static Future<NewestCookieIdModel> getCdnNewestCookieId(String combId) async {
    final String cdnNewestCookieIdUrl = "/datasource-comb/$combId";
    ResponseData response = await HttpClass.get(cdnNewestCookieIdUrl, type: 4);
    if (response.error) {
      return NewestCookieIdModel();
    } else {
      return NewestCookieIdModel.fromJson(response.data);
    }
  }
}