import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/version_2.0/model/info/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manager/settingManager.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';
import '../../request/cookie/cookie_request.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  Rx<DatasourceModel> datasourceSetting =
      SettingManager.getInstance().datasourceSetting;

  @override
  void onInit() {
    super.onInit();
    //_requestCookieList();
  }

  Future<void> _requestCookieList() async {
    NewestCookieIdModel newestIdResp = await CookiesApi.getCdnNewestCookieId(
        datasourceSetting.value.datasourceCombId);
    state.newestCookieId = newestIdResp;
    CookieMainListModel cookiesResp = await CookiesApi.getCdnCookieMainList(
        datasourceSetting.value.datasourceCombId,
        newestIdResp.cookieId!,
        newestIdResp.updateCookieId);
    // 如果请求失败，updateId让它为空再请求一次
    if (cookiesResp.cookies.isEmpty) {
      cookiesResp = await CookiesApi.getCdnCookieMainList(
          datasourceSetting.value.datasourceCombId,
          newestIdResp.cookieId!,
          null);
      state.newestCookieId?.updateCookieId = null;
    }
    state.data = cookiesResp.cookies;
    state.nextPageId = cookiesResp.nextPageId;
  }

  Future<void> onRefresh() async {}

  void handleSearch() {}

  void onTapShare(BuildContext context, Cookie) {}

  void onTapCard(BuildContext context, String type, String id, String url) {
    String appUrl = "";
    if (type == "bilibili:dynamic-by-uid") {
      // bilibili
      appUrl = "bilibili://following/detail/$id";
    } else if (type == "weibo:dynamic-by-uid") {
      // weibo
      appUrl = "sinaweibo://detail?mblogid=$id";
    } else if (type == "netease-cloud-music:albums-by-artist") {
      // 网易云音乐
      appUrl = "orpheus://album/$id";
    }
    // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
    OpenAppOrBrowser.openUrl(url, context, appUrlScheme: appUrl);
  }
}
