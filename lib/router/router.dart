
import 'package:dun_cookie_flutter/page/main/main_page.dart';
import 'package:dun_cookie_flutter/page/manga/manga_list.dart';
import 'package:dun_cookie_flutter/page/webview/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main.dart';

import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:flutter/material.dart';

import '../page/error/main.dart';
import '../page/main/ui/home/cookie_share.dart';

class DunRouter {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => const MainPage(), //主页|预加载
    DunWebView.routeName: (context) => const DunWebView(),
    DunUpdate.routerName: (context) => const DunUpdate(),
    CookieWidgetToImage.routeName: (context) => const CookieWidgetToImage(),
  };
}
