import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider();

  // 路由初始化页面
  int _routerIndex = StaticVariable.starRouterIndex;

  int get routerIndex {
    return _routerIndex;
  }

  setRouterIndex(index) {
    _routerIndex = index;
    setThemeIndex(index);
  }

  // 主题index
  int _themeIndex = StaticVariable.starThemeIndex;

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
  List<String> _checkSource = [];

  List<String> get checkSource {
    // 这里调用上面的异步获取值 如果没有就直接等于下面的数组
    if (_checkSource.isEmpty) {
      checkSourceInPreferences();
    }
    return _checkSource;
  }

  void checkSourceInPreferences() {
    DunPreferences().getStringList(key: "listCheckSource").then((value) {
      if (value != null && value.length > 0) {
        _checkSource = value;
      } else {
        _checkSource = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
      }

      notifyListeners();
    });
  }

  void setCheckListInPriority(priority, isAdd) async {
    if (isAdd) {
      _checkSource.add(priority);
    } else {
      _checkSource.remove(priority);
    }
    // 保存记录
    DunPreferences()
        .saveStringList(key: "listCheckSource", value: _checkSource);
    notifyListeners();
  }
}
