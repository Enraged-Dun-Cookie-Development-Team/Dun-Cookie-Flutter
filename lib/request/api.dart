import 'dart:math';

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

  static String bakeryMansionInfoUrl(String id) =>
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
