import 'package:dun_cookie_flutter/version_2.0/page/register/view.dart';
import 'package:flutter/material.dart';

import 'page/rootPage.dart';

class DunRouter {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) => const RootPage(), //主页|预加载
    "/register": (context) => RegisterPage(),
  };
}
