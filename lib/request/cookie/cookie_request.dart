import '../../model/cookie/cookie_count.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';
import '../request.dart';
import '../respond.dart';

/// 饼相关
class CookiesApi {
  /// 饼数量
  static Future<CookieInfoCountModel> getCookieInfoCount() async {
    ResponseData response = await HttpClass.get(UrlString.cookieInfoCountUrl,
        type: RequestType.server);
    if (response.error) {
      return CookieInfoCountModel(
          totalCount: 0,
          skinCount: 0,
          operatorCount: 0,
          activityCount: 0,
          epCount: 0);
    } else {
      return CookieInfoCountModel.fromJson(response.data['data']);
    }
  }

  /// 饼主列表
  static Future<CookieMainListModel> getCdnCookieMainList(
      String combId, String cookieId, String? updateCookieId) async {
    Map<String, dynamic> map = {
      "datasource_comb_id": combId,
      "cookie_id": cookieId,
    };
    if (updateCookieId?.isNotEmpty == true) {
      map["update_cookie_id"] = updateCookieId;
    }
    ResponseData response = await HttpClass.get(UrlString.cdnCookieMainList,
        params: map, type: RequestType.serveCdn);
    if (response.error) {
      return CookieMainListModel(cookies: []);
    } else {
      return CookieMainListModel.fromJson(response.data['data']);
    }
  }

  /// 饼搜索列表
  static Future<CookieMainListModel> getCookieSearchList(
      String combId, String searchWord, String? cookieId) async {
    Map<String, dynamic> map = {
      "datasource_comb_id": combId,
      "search_word": searchWord,
    };
    if (cookieId?.isNotEmpty == true) {
      map["cookie_id"] = cookieId;
    }
    ResponseData response = await HttpClass.get(UrlString.cookieSearchList,
        params: map, type: RequestType.server);
    if (response.error) {
      return CookieMainListModel(cookies: []);
    } else {
      return CookieMainListModel.fromJson(response.data['data']);
    }
  }

  /// 最新饼id
  static Future<NewestCookieIdModel> getCdnNewestCookieId(String combId) async {
    ResponseData response = await HttpClass.get(
        UrlString.cdnNewestCookieIdUrl(combId),
        type: RequestType.cdn);
    if (response.error) {
      return NewestCookieIdModel.fromJson({});
    } else {
      return NewestCookieIdModel.fromJson(response.data);
    }
  }
}
