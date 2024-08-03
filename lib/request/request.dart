import 'dart:math';

import 'package:dio/dio.dart';

import '../manager/settingManager.dart';
import 'config.dart';
import 'respond.dart';

enum RequestType {
  temp,
  server,
  ceobecanteen,
  serveCdn,
  cdn,
  none,
}

class UrlString {
  // 饼相关
  static String get cookieInfoCountUrl => "/canteen/cookie/info/count";

  static String get cookieSearchList => "/canteen/cookie/search/list";

  static String cdnNewestCookieIdUrl(combId) => "/datasource-comb/$combId";

  static String get cdnCookieMainList => "/cdn/cookie/mainList/cookieList";

  // 配置相关
  static String get configDatasourceUrl => "/canteen/config/datasource/list";

  static String get updateDataSourceUrl =>
      "/canteen/user/updateDatasourceConfig";

  // 漫画相关
  static String get terraComicListUrl => "/canteen/cookie/terraComic/list";

  static String terraComicEpisodeUrl(String comicId) =>
      "/canteen/cookie/terraComic/episodeList?comic=$comicId";

  static String get terraNewestEpisodeUrl =>
      "/canteen/cookie/terraComic/newestEpisode";

  // 蜜饼工坊
  static String get testBakeryInfoUrl =>
      "/canteen/workshop?${Random().nextInt(100000).toString()}";

  static String get bakeryMansionIdListUrl => "/canteen/bakery/mansionId";

  static String bakeryMansionInfoUrl(id) =>
      "/canteen/bakery/mansionInfo?mansion_id=$id";

  static String get bakeryRecentPredictUrl =>
      "/canteen/bakery/mansion/recentPredict";

  // 用户信息
  static String get appVersionUrl => "/canteen/operate/version/app";

  static String get createUserUrl => "/canteen/user/createUser";

  static String get userDatasourceSettingsUrl =>
      "/canteen/user/datasourceConfig";

  // 工具相关
  static String get videoRecommendUrl => "/canteen/operate/video/list";

  static String get resourceInfoUrl => "/canteen/operate/resource/get";

  static String get toolLinkInfoUrl => "/canteen/operate/toolLink/list";
}

class HttpClass {
  static final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: HttpConfig.timeout,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  );

  static final Dio dio = Dio(_baseOptions);

  static Future _request(
    String url, {
    String method = "get",
    Map<String, dynamic>? params,
    data,
    RequestType type = RequestType.none,
  }) async {
    final options = Options(method: method);
    switch (type) {
      case RequestType.none:
        dio.options.baseUrl = "";
        break;
      case RequestType.temp:
        dio.options.baseUrl = HttpConfig.tempBaseUrl;
        break;
      case RequestType.server:
        dio.options.baseUrl = HttpConfig.serverBaseUrl;
        break;
      case RequestType.ceobecanteen:
        dio.options.baseUrl = HttpConfig.ceobecanteenBaseUrl;
        break;
      case RequestType.serveCdn:
        dio.options.baseUrl = HttpConfig.serveCdnBaseUrl;
        break;
      case RequestType.cdn:
        dio.options.baseUrl = HttpConfig.cdnBaseUrl;
        break;
    }
    try {
      dio.options.headers.addAll({
        "mob-id": SettingManager.getInstance().rid,
      });
      print("请求 ${dio.options.baseUrl}$url");
      Response response = await dio.request(
        url,
        queryParameters: params,
        data: data,
        options: options,
      );
      return ResponseData(error: false, data: response.data, msg: "");
    } on DioError catch (e) {
      return ResponseData(
          error: true, data: e.response?.data, msg: e.message ?? '');
    }
  }

  static Future get(String url, {params, RequestType type = RequestType.temp}) {
    return _request(url, params: params, type: type);
  }

  static Future post(String url,
      {Map<String, dynamic>? params,
      data,
      RequestType type = RequestType.temp}) {
    return _request(url,
        method: "post", params: params, data: data, type: type);
  }
}
