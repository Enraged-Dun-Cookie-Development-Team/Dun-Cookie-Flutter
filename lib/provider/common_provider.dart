import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider();

  // 路由初始化页面
  int _routerIndex = 0;

  int get routerIndex {
    return _routerIndex;
  }

  setRouterIndex(index) {
    _routerIndex = index;
    setThemeIndex(index);
  }

  // 主题index
  int _themeIndex = 0;

  int get themeIndex {
    return _themeIndex;
  }

  setThemeIndex(index) {
    _themeIndex = index;
    if (themeIndex > DunTheme.themeList.length - 1) {
      _themeIndex = 0;
    }
    DunPreferences().saveInt(key: "themeName", value: _themeIndex);
    notifyListeners();
  }

  // 选中的来源
  final List<String> _checkSource = [];

  static get checkSource async {
    var _checkSource =
        await DunPreferences().getStringList(key: "listCheckSource");
    return _checkSource;
  }

  void setCheckListInPriority(priority, isAdd) async {
    if (isAdd) {
      _checkSource.add(priority);
    } else {
      _checkSource.removeWhere((element) => element == priority);
    }
    // 保存记录
    DunPreferences()
        .saveStringList(key: "listCheckSource", value: _checkSource);
    notifyListeners();
  }
}
