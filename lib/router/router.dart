import 'package:dun_cookie_flutter/page/Error/main.dart';
import 'package:dun_cookie_flutter/page/browser/main.dart';
import 'package:dun_cookie_flutter/page/main/dun_main.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:dun_cookie_flutter/page/main/dun_share.dart';
import 'package:flutter/material.dart';

class DunRouter {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => const MainScaffold(),
    "/mbgf": (context) => const MainScaffold(),
    "/setting": (context) => const Setting(),
    DunWidgetToImage.routeName: (context) => DunWidgetToImage(),
    DunWebView.routeName: (context) => DunWebView(),
  };

  /// 添加页面后记得在上面加上 不然就会直接跳转到404
  static Route routeGenerator(RouteSettings settings) {
    final String? name = settings.name;
    final Function? pageBuilder = routes[name];
    if (pageBuilder != null) {
      if (settings.arguments != null) {
        // 如果透传了参数
        return MaterialPageRoute(
            builder: (context) =>
                pageBuilder(context, arguments: settings.arguments));
      } else {
        // 没有透传参数
        return MaterialPageRoute(builder: (context) => pageBuilder(context));
      }
    }
    return MaterialPageRoute(builder: (context) => DunError(error: "404"));
  }
}
