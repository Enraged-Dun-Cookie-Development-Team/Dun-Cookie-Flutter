import 'package:dun_cookie_flutter/model/cookie_main_list_model.dart';

import 'main.dart';

class ServeCdnCookieApi {
  /// 饼主列表
  static String cdnCookieMainList = "/cdn/cookie/mainList/cookieList";
  static Future<CookieMainListModel> getCdnCookieMainList(
      String combId, String cookieId, String? updateCookieId) async {
    Map<String, dynamic> map = {
      "datasource_comb_id": combId,
      "cookie_id": cookieId,
    };
    if (updateCookieId?.isNotEmpty == true) {
      map["update_cookie_id"] = updateCookieId;
    }
    ResponseData response =
        await HttpClass.get(cdnCookieMainList, params: map, type: 3);
    if (response.error) {
      return CookieMainListModel();
    } else {
      return CookieMainListModel.fromJson(response.data['data']);
    }
  }
}
