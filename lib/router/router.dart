import 'package:dun_cookie_flutter/common/browser/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/page/bakery/main.dart';
import 'package:dun_cookie_flutter/page/comics/main.dart';
import 'package:dun_cookie_flutter/page/donate/main.dart';
import 'package:dun_cookie_flutter/page/home/main.dart';
import 'package:dun_cookie_flutter/page/setting/setting_info.dart';
import 'package:dun_cookie_flutter/page/main/dun_list.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:dun_cookie_flutter/page/setting/setting_source_filter.dart';
import 'package:dun_cookie_flutter/page/tool/main.dart';
import 'package:dun_cookie_flutter/page/main/dun_share.dart';
import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:flutter/material.dart';

class DunRouter {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => MainScaffold(),
    Bakery.routeName: (context) => Bakery(),
    DunList.routeName: (context) => const DunList(),
    DunWidgetToImage.routeName: (context) => DunWidgetToImage(),
    DunWebView.routeName: (context) => DunWebView(),
    DunTool.routeName: (context) => const DunTool(),
    DunSetting.routerName: (context) => const DunSetting(),
    SettingSourceFilter.routerName: (context) => const SettingSourceFilter(),
    DunInfo.routerName: (context) => const DunInfo(),
    DunUpdate.routerName: (context) => const DunUpdate(),
    Donate.routerName: (context) => const Donate(),
    Comics.routerName: (context) => const Comics(),
  };

  /// 侧边菜单固定项目
  static const pageTitles = ["小刻食堂", "蜜饼工坊", "官方漫画", "常用工具", "设置与其他"];
  static var pages = [const DunList(), Bakery(), const Comics(), const DunTool(), const DunSetting()];
  static const pagesIcon = [
    Image(image:AssetImage("assets/logo/logo_item.png"),height: 30,),
    Image(image:AssetImage("assets/logo/logo_mb.png"),height: 30,),
    Icon(Icons.book,size: 30,color: DunColors.DunColor,),
    Icon(Icons.handyman,size: 30,color: DunColors.DunColor,),
    Icon(Icons.settings,size: 30,color: DunColors.DunColor),
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
