import '../model/cookie_model.dart';
import 'main.dart';

/// 饼相关
class CookiesApi {
  /// 特定饼数量
  static String cookieInfoCountUrl = "/canteen/cookie/info/count";

  static Future<CookieInfoCountModel> getCookieCountList() async {
    ResponseData response = await HttpClass.get(cookieInfoCountUrl, type: 1);
    if (response.error) {
      return CookieInfoCountModel();
    } else {
      return CookieInfoCountModel.fromJson(response.data['data']);
    }
  }
}