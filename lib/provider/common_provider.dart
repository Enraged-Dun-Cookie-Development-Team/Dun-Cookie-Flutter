import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/pubilc.dart';
import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider();

  // 路由初始化页面
  int _routerIndex = 2;

  int get routerIndex {
    return _routerIndex;
  }

  int _themeIndex = 0;

  int get themeIndex {
    return _themeIndex;
  }

  setRouterIndex(index) {
    _routerIndex = index;
    setThemeIndex(index);
  }

  setThemeIndex(index) {
    _themeIndex = index;
    if (themeIndex > DunTheme.themeList.length - 1) {
      _themeIndex = 0;
    }
    DunPreferences().saveInt(key: "themeName", value: _themeIndex);
    notifyListeners();
  }
}
