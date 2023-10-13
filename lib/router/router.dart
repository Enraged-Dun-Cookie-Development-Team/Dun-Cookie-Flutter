
import 'package:dun_cookie_flutter/page/manga/manga_list.dart';
import 'package:dun_cookie_flutter/page/webview/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main.dart';

import 'package:dun_cookie_flutter/page/widgetToImage/dun_share.dart';

import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:flutter/material.dart';

import '../page/error/main.dart';
import '../page/main/ui/home/cookie_share.dart';

class DunRouter {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => const BottomNavBar(), //主页|预加载
    DunWebView.routeName: (context) => const DunWebView(),
    DunUpdate.routerName: (context) => const DunUpdate(),
    DunWidgetToImage.routeName: (context) => const DunWidgetToImage(),
    CookieWidgetToImage.routeName: (context) => const CookieWidgetToImage(),
  };

  /// 侧边菜单固定项目
  static const pageTitles = ["小刻食堂", "蜜饼工坊", "官方漫画", "泰拉每周速递", "常用工具", "设置与其他"];
  static const pagesIcon = [
    Image(
      image: AssetImage("assets/logo/logo_item.png"),
      height: 30,
    ),
    Image(
      image: AssetImage("assets/logo/logo_mb.png"),
      height: 30,
    ),
    Icon(
      Icons.book,
      size: 30,
      color: DunColors.DunColor,
    ),
    Icon(
      Icons.supervisor_account,
      size: 30,
      color: DunColors.DunColor,
    ),
    Icon(
      Icons.handyman,
      size: 30,
      color: DunColors.DunColor,
    ),
    Icon(Icons.settings, size: 30, color: DunColors.DunColor),
  ];

  /// 添加页面后记得在上面加上 不然就会直接跳转到404
  static Route routeGenerator(RouteSettings settings) {
    final String? name = settings.name;
    final Function? pageBuilder = routes[name];
    if (pageBuilder != null) {
      if (settings.arguments != null) {
        // 如果传了参数
        return MaterialPageRoute(
            builder: (context) =>
                pageBuilder(context, arguments: settings.arguments));
      } else {
        // 没有传参数
        return MaterialPageRoute(builder: (context) => pageBuilder(context));
      }
    }
    return MaterialPageRoute(builder: (context) => DunError(error: "404"));
  }
}
