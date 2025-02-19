import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/cookie_share/view.dart';
import 'page/datasource/view.dart';
import 'page/honey_cake_workshop/view.dart';
import 'page/manga/view.dart';
import 'page/register/view.dart';
import 'page/root/view.dart';
import 'page/setting/view.dart';
import 'page/update/view.dart';
import 'page/web/view.dart';

DunObserver routeObserver = DunObserver();

class DunObserver extends RouteObserver<PageRoute> {
  static Route? loadingDialogRoute;

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route.settings.name == DunDialogRoute.loading.name) {
      loadingDialogRoute = null;
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name == DunDialogRoute.loading.name) {
      loadingDialogRoute = route;
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (route.settings.name == DunDialogRoute.loading.name) {
      loadingDialogRoute = null;
    }
    super.didRemove(route, previousRoute);
  }
}

enum DunDialogRoute {
  loading;
}

class DunRouter {
  static const String root = '/';
  static const String register = '/register';
  static const String manga = '/manga';
  static const String honeyCake = '/honeyCake';
  static const String setting = '/setting';
  static const String datasourceSetting = '/datasourceSetting';
  static const String update = '/update';
  static const String share = '/share';
  static const String web = '/web';

  /// 别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: root, page: () => RootPage()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: manga, page: () => MangaPage()),
    GetPage(name: honeyCake, page: () => HoneyCakeWorkshopPage()),
    GetPage(name: setting, page: () => SettingPage()),
    GetPage(name: datasourceSetting, page: () => DatasourcePage()),
    GetPage(name: update, page: () => UpdatePage()),
    GetPage(name: share, page: () => CookieSharePage()),
    GetPage(name: web, page: () => WebPage())
  ];
}
