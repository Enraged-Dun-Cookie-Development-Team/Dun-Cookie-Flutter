import 'package:dun_cookie_flutter/model/Terra_comic_episode_model.dart';
import 'package:dun_cookie_flutter/model/terra_comic_model.dart';

import '../model/cookie_count_model.dart';
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

  /// 泰拉记事社漫画列表
  static String terraComicListUrl = "/canteen/cookie/terraComic/list";
  static Future<List<TerraComicModel>> getTerraComicList() async {
    ResponseData response = await HttpClass.get(terraComicListUrl, type: 1);
    if (response.error) {
      return [];
    } else {
      return _responseDataToTerraComicListData(response);
    }
  }

  static List<TerraComicModel> _responseDataToTerraComicListData(ResponseData request) {
    List<TerraComicModel> resultAll = [];
    if (request.data is Map) {
      Map map = request.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(TerraComicModel.fromJson(model));
        }
      }
    }
    return resultAll;
  }

  /// 泰拉记事社漫画小节列表
  static _getTerraComicEpisodeUrl(String comicId) {
    return "/canteen/cookie/terraComic/episodeList?comic=$comicId";
  }
  static Future<List<TerraComicEpisodeModel>> getTerraComicEpisodeList(String comicId) async {
    ResponseData response = await HttpClass.get(_getTerraComicEpisodeUrl(comicId) as String, type: 1);
    if (response.error) {
      return [];
    } else {
      return _responseDataToTerraComicEpisodeListData(response);
    }
  }

  static List<TerraComicEpisodeModel> _responseDataToTerraComicEpisodeListData(ResponseData request) {
    List<TerraComicEpisodeModel> resultAll = [];
    if (request.data is Map) {
      Map map = request.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(TerraComicEpisodeModel.fromJson(model));
        }
      }
    }
    return resultAll;
  }
}