import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../common/debounce_throttle.dart';
import '../../../common/dun_dialog.dart';
import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import '../../manager/setting_manager.dart';
import '../../model/cookie/cookie_main_list.dart';
import '../../model/cookie/newest_cookie_id.dart';
import '../../model/info/user_settings.dart';
import '../../request/cookie/cookie_request.dart';
import '../../route.dart';
import '../root/logic.dart';
import 'state.dart';

class CookiesLogic extends GetxController {
  final CookiesState state = CookiesState();

  UserDatasourceModel get datasourceSetting =>
      SettingManager.getInstance().datasourceSetting.value;

  @override
  void onInit() {
    super.onInit();
    refreshData();
    state.scrollController.addListener(() {
      if (state.scrollController.position.pixels ==
          state.scrollController.position.maxScrollExtent) {
        loadData();
      }
    });
    RootLogic.to?.state.scrollHideController
        .addScrollController(state.scrollController);
    state.searchController.addListener(() {
      var debounce = EventFilter.debounce("list_search_word", () {
        state.clearButtonVisible.value = state.searchController.text.isNotEmpty;
        if (state.searchController.text.isEmpty && state.searchStatue.value) {
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

  Future<bool> updateNewestCookieId() async {
    var responseData = await CookiesApi.getCdnNewestCookieId(
        datasourceSetting.datasourceCombId);
    if (!responseData.error) {
      NewestCookieIdModel? data = responseData.data;
      if (data != null) {
        if (data.cookieId == state.newestCookieId.cookieId &&
            data.updateCookieId == state.newestCookieId.cookieId) {
          update([state.listGID]);
        } else {
          state.newestCookieId = data;
          return true;
        }
      }
    }
    return false;
  }

  Future<void> refreshData() async {
    if (state.searchStatue.value) {
      var responseData = await CookiesApi.getCookieSearchList(
        combId: datasourceSetting.datasourceCombId,
        searchWord: state.lastSearchContent,
      );
      if (responseData.error) {
        //获取搜索饼列表失败
        DunToast.showError("请求失败");
      }
      CookieMainListModel? searchList = responseData.data;
      if (searchList != null) {
        state.searchCookieList.value = searchList.cookies;
        state.searchNextPageId.value = searchList.nextPageId;
      }
    } else {
      bool result = await updateNewestCookieId();
      if (result) {
        var responseData = await CookiesApi.getCdnCookieMainList(
            combId: datasourceSetting.datasourceCombId,
            cookieId: state.newestCookieId.cookieId,
            updateCookieId: state.newestCookieId.updateCookieId);
        if (responseData.error) {
          //获取饼列表失败
          responseData = await CookiesApi.getCdnCookieMainList(
            combId: datasourceSetting.datasourceCombId,
            cookieId: state.newestCookieId.cookieId,
          );
          if (responseData.error) {
            //二次请求饼列表失败
            DunToast.showError("请求失败");
            return;
          }
          state.newestCookieId.cookieId = '';
        }
        CookieMainListModel? mainList = responseData.data;
        if (mainList != null) {
          state.cookieList.value = mainList.cookies;
          state.nextPageId.value = mainList.nextPageId;
        }
      }
    }
  }

  Future<void> loadData() async {
    if (state.searchStatue.value) {
      var responseData = await CookiesApi.getCookieSearchList(
          combId: datasourceSetting.datasourceCombId,
          searchWord: state.lastSearchContent,
          cookieId: state.searchNextPageId.value);
      if (responseData.error) {
        //获取搜索饼列表失败
        DunToast.showError("请求失败");
      }
      CookieMainListModel? searchList = responseData.data;
      if (searchList != null) {
        state.searchCookieList.addAll(searchList.cookies);
        state.searchNextPageId.value = searchList.nextPageId;
      }
    } else {
      var responseData = await CookiesApi.getCdnCookieMainList(
          combId: datasourceSetting.datasourceCombId,
          cookieId: state.nextPageId.value,
          updateCookieId: state.newestCookieId.updateCookieId);
      if (responseData.error) {
        //获取饼列表失败
        responseData = await CookiesApi.getCdnCookieMainList(
          combId: datasourceSetting.datasourceCombId,
          cookieId: state.newestCookieId.cookieId,
        );
        if (responseData.error) {
          //二次请求饼列表失败
          DunToast.showError("请求失败");
          return;
        }
        state.newestCookieId.cookieId = '';
      }
      CookieMainListModel? mainList = responseData.data;
      if (mainList != null) {
        state.cookieList.addAll(mainList.cookies);
        state.nextPageId.value = mainList.nextPageId;
      }
    }
  }

  Future<void> onRefresh() async {
    if (state.isAllowRefresh) {
      state.isAllowRefresh = false;
      refreshData();
      Future.delayed(const Duration(seconds: 10), () {
        state.isAllowRefresh = true;
      });
    } else {
      DunToast.showError("小刻别急！！！");
    }
  }

  void cancelSearch() {
    state.searchStatue.value = false;
    if (state.searchCookieList.isNotEmpty) {
      state.scrollController.jumpTo(0);
    }
    refreshData().then((value) {
      state.searchCookieList.clear();
      state.searchNextPageId.value = '';
      state.lastSearchContent = '';
    });
  }

  void handleSearch() {
    var searchText = state.searchController.text;
    if (searchText == state.lastSearchContent) {
      return;
    } else {
      state.searchStatue.value = true;
      state.lastSearchContent = searchText;
      state.scrollController
          .animateTo(0,
              duration: const Duration(milliseconds: 1), curve: Curves.linear)
          .then((value) => loadData());
    }
  }

  onTapShare(Cookie cookie) {
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
