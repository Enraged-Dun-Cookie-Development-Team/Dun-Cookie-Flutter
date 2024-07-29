import 'package:dun_cookie_flutter/page/root/logic.dart';
import 'package:dun_cookie_flutter/route.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../common/debounce_throttle.dart';
import '../../../common/dun_dialog.dart';
import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import '../../manager/settingManager.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';
import '../../model/info/user_settings.dart';
import '../../request/cookie/cookie_request.dart';
import 'state.dart';

class CookiesLogic extends GetxController {
  final CookiesState state = CookiesState();

  @override
  void onInit() {
    super.onInit();
    loadData(refresh: true);
    state.scrollController.addListener(() {
      if (state.scrollController.position.pixels ==
          state.scrollController.position.maxScrollExtent) {
        loadData(more: true);
      }
    });
    RootLogic.to?.state.scrollHideController
        .addScrollController(state.scrollController);
    state.searchController.addListener(() {
      var debounce = EventFilter.debounce("list_search_word", () {
        bool isNotEmpty = state.searchController.text.isNotEmpty;
        if (state.offstage.value == isNotEmpty) {
          state.offstage.value = !isNotEmpty;
        }
        if (!isNotEmpty && state.searchStatue) {
          cancelSearch();
        }
      }, duration: const Duration(milliseconds: 100));
      debounce();
    });
  }

  @override
  void onClose() {
    state.searchController.dispose();
    state.scrollController.dispose();
  }

  Future<void> loadData({bool refresh = false, bool more = false}) async {
    UserDatasourceModel datasourceSetting =
        SettingManager.getInstance().datasourceSetting.value;
    if (state.searchStatue) {
      CookieMainListModel cookiesResp = await CookiesApi.getCookieSearchList(
          datasourceSetting.datasourceCombId,
          state.lastSearchContent,
          more ? state.searchNextPageId : null);
      more
          ? state.searchCookieList.addAll(cookiesResp.cookies)
          : state.searchCookieList = cookiesResp.cookies;
      state.searchNextPageId = cookiesResp.nextPageId;
    } else {
      NewestCookieIdModel newestCookieId =
          await CookiesApi.getCdnNewestCookieId(
              datasourceSetting.datasourceCombId);
      if (newestCookieId == state.newestCookieId && !more) {
        if (refresh) update([state.listGID]);
        return;
      }
      state.newestCookieId = newestCookieId;
      CookieMainListModel cookiesResp = await CookiesApi.getCdnCookieMainList(
          datasourceSetting.datasourceCombId,
          more ? state.nextPageId! : state.newestCookieId.cookieId,
          state.newestCookieId.updateCookieId);
      // 如果请求失败，updateId让它为空再请求一次
      if (cookiesResp.cookies.isEmpty) {
        cookiesResp = await CookiesApi.getCdnCookieMainList(
            datasourceSetting.datasourceCombId,
            more ? state.nextPageId! : state.newestCookieId.cookieId,
            null);
        state.newestCookieId.updateCookieId = '';
      }
      more
          ? state.cookieList.addAll(cookiesResp.cookies)
          : state.cookieList = cookiesResp.cookies;
      state.nextPageId = cookiesResp.nextPageId;
    }
    update([state.listGID]);
  }

  Future<void> onRefresh() async {
    if (state.isAllowRefresh) {
      await loadData(refresh: true);
      state.isAllowRefresh = false;
      Future.delayed(const Duration(seconds: 10), () {
        state.isAllowRefresh = true;
      });
    } else {
      DunToast.showError("小刻别急！！！");
    }
  }

  void cancelSearch() {
    state.searchStatue = false;
    if (state.searchCookieList.isNotEmpty) {
      state.scrollController.jumpTo(0);
    }
    loadData(refresh: true).then((value) {
      state.searchCookieList.clear();
      state.searchNextPageId = null;
      state.lastSearchContent = '';
    });
  }

  void handleSearch() {
    var searchText = state.searchController.text;
    if (searchText == state.lastSearchContent) {
      return;
    } else {
      state.searchStatue = true;
      state.lastSearchContent = searchText;
      state.scrollController
          .animateTo(0,
              duration: const Duration(milliseconds: 1), curve: Curves.linear)
          .then((value) => loadData());
    }
  }

  onTapShare(Cookie cookie) {
    //todo 分享页跳转
    Get.toNamed(DunRouter.share, arguments: cookie);
  }

  onTapCard(Cookie cookie) {
    String type = cookie.source.type;
    String appUrl = "";
    if (type == "bilibili:dynamic-by-uid") {
      // bilibili
      appUrl = "bilibili://following/detail/${cookie.item.id}";
    } else if (type == "weibo:dynamic-by-uid") {
      // weibo
      appUrl = "sinaweibo://detail?mblogid=${cookie.item.id}";
    } else if (type == "netease-cloud-music:albums-by-artist") {
      // 网易云音乐
      appUrl = "orpheus://album/${cookie.item.id}";
    }
    DunJump.openAppOrWebPage(url: cookie.item.url, appUrlScheme: appUrl);
  }

  onTapImage(List<String> imageURLList, int initialIndex) {
    showImageViewDialog(imageURLList, initialIndex);
  }
}
