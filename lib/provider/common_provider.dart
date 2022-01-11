import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/pubilc.dart';
import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider();

  // 路由初始化页面
  int routerIndex = 1;

  int themeIndex = 0;

  setRouterIndex(index) {
    routerIndex = index;
    setThemeIndex(index);
    notifyListeners();
  }

  setThemeIndex(index) {
    themeIndex = index;
    if (themeIndex > DunTheme.themeList.length - 1) {
      themeIndex = 0;
    }
    DunPreferences().saveInt(key: "themeName", value: index);
    notifyListeners();
  }
}
