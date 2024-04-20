import '../../model/cookie_main_list_model.dart';
import '../../model/cookie_count_model.dart';
import '../../model/newest_cookie_id_model.dart';
import '../request.dart';
import '../respond.dart';

/// 饼相关
class CookiesApi {
  /// 饼数量
  static Future<CookieInfoCountModel> getCookieInfoCount() async {
    ResponseData response = await HttpClass.get(UrlString.cookieInfoCountUrl,
        type: RequestType.server);
    if (response.error) {
      return CookieInfoCountModel();
    } else {
      return CookieInfoCountModel.fromJson(response.data['data']);
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
      return CookieMainListModel();
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
      return NewestCookieIdModel();
    } else {
      return NewestCookieIdModel.fromJson(response.data);
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
      return CookieMainListModel();
    } else {
      return CookieMainListModel.fromJson(response.data['data']);
    }
  }
}
