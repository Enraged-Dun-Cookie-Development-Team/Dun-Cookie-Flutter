
import 'package:dun_cookie_flutter/common/browser/main.dart';
import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/page/bakery/main.dart';
import 'package:dun_cookie_flutter/page/home/main.dart';
import 'package:dun_cookie_flutter/page/main/dun_list.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:dun_cookie_flutter/page/setting/setting_source_filter.dart';
import 'package:dun_cookie_flutter/page/tool/main.dart';
import 'package:dun_cookie_flutter/page/main/dun_share.dart';
import 'package:dun_cookie_flutter/page/update_dialog/main.dart';
import 'package:flutter/material.dart';

class DunRouter {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => MainScaffold(),
    Bakery.routeName: (context) => Bakery(),
    DunList.routeName: (context) => DunList(),
    DunWidgetToImage.routeName: (context) => DunWidgetToImage(),
    DunWebView.routeName: (context) => DunWebView(),
    DunTool.routeName: (context) => DunTool(),
    DunSetting.routerName: (context) => DunSetting(),
    SettingSourceFilter.routerName: (context) => SettingSourceFilter()
  };

  /// 底部栏用
  static const pageTitles = ["小刻食堂 alpha", "蜜饼工坊 alpha", "常用工具 alpha"];
  static const pages = [DunList(), Bakery(), DunTool()];

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
