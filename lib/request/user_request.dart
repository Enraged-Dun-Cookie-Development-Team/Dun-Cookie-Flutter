import 'package:dun_cookie_flutter/model/bilibili_favorites_data.dart';
import 'package:dun_cookie_flutter/model/bilibili_user_favlist_data.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class UserRequest {
  static int requestType = -1;

  static Future<BilibiliUserFavlistData> getUserFavlist(int id) async {
    final url =
        "https://api.bilibili.com/x/v3/fav/folder/created/list-all?up_mid=$id&jsonp=jsonp";
    print("请求用户的收藏");
    var data = await HttpClass.get(url, type: requestType);
    if (!data.error) {
      var result = BilibiliUserFavlistData.fromJson(data.data);
      return result;
    }
    return BilibiliUserFavlistData();
  }

  static Future<BilibiliFavoritesData> getUserFav(int id) async {
    final url =
        "https://api.bilibili.com/x/v3/fav/resource/list?media_id=$id&pn=1&ps=20&keyword=&order=mtime&type=0&tid=0&platform=web&jsonp=jsonp";
    print("请求收藏详情");
    var data = await HttpClass.get(url, type: requestType);
    if (!data.error) {
      return BilibiliFavoritesData.fromJson(data.data);
    }
    return BilibiliFavoritesData();
  }
}
