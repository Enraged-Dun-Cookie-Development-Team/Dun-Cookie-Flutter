import '../../model/cookie/cookie_count.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';
import '../api.dart';
import '../request.dart';
import '../respond.dart';

/// 饼相关
class CookiesApi {
  /// 饼数量
  static Future<ResponseData<CookieInfoCountModel>> getCookieInfoCount() async {
    ResponseData<CookieInfoCountModel> response =
        await HttpClass.get<CookieInfoCountModel>(UrlString.cookieInfoCountUrl,
            type: RequestType.server, fromJson: CookieInfoCountModel.fromJson);
    return response;
  }

  /// 饼主列表
  static Future<ResponseData<CookieMainListModel>> getCdnCookieMainList(
      {required String combId,
      required String cookieId,
      String? updateCookieId}) async {
    Map<String, dynamic> map = {
      "datasource_comb_id": combId,
      "cookie_id": cookieId,
    };
    if (updateCookieId?.isNotEmpty == true) {
      map["update_cookie_id"] = updateCookieId;
    }
    ResponseData<CookieMainListModel> response =
        await HttpClass.get<CookieMainListModel>(UrlString.cdnCookieMainList,
            params: map,
            type: RequestType.serveCdn,
            fromJson: CookieMainListModel.fromJson);
    return response;
  }

  /// 饼搜索列表
  static Future<ResponseData<CookieMainListModel>> getCookieSearchList(
      {required String combId,
      required String searchWord,
      String? cookieId}) async {
    Map<String, dynamic> map = {
      "datasource_comb_id": combId,
      "search_word": searchWord,
    };
    if (cookieId?.isNotEmpty == true) {
      map["cookie_id"] = cookieId;
    }
    ResponseData<CookieMainListModel> response =
        await HttpClass.get<CookieMainListModel>(UrlString.cookieSearchList,
            params: map,
            type: RequestType.server,
            fromJson: CookieMainListModel.fromJson);
    return response;
  }

  /// 最新饼id
  static Future<ResponseData<NewestCookieIdModel>> getCdnNewestCookieId(
      String combId) async {
    ResponseData<NewestCookieIdModel> response =
        await HttpClass.get<NewestCookieIdModel>(
            UrlString.cdnNewestCookieIdUrl(combId),
            type: RequestType.cdn,
            fromJson: NewestCookieIdModel.fromJson);
    return response;
  }
}
