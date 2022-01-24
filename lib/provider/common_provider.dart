import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
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
    return _checkSource;
  }

  set checkSource(List<String> value) {
    _checkSource = value;
    notifyListeners();
  }

  Future checkSourceInPreferences() async {
    List<String> value =
        await DunPreferences().getStringList(key: "listCheckSource");
    if (value != null && value.length > 0) {
      checkSource = value;
    } else {
      checkSource = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    }
  }

  void setCheckListInPriority(priority, isAdd) async {
    if (isAdd) {
      checkSource.add(priority);
    } else {
      checkSource.remove(priority);
    }
    checkSource = checkSource;
    // 保存记录
    DunPreferences()
        .saveStringList(key: "listCheckSource", value: _checkSource);
  }

//  获取到的数据
  List<SourceData> _sourceData = [];

  List<SourceData> get sourceData {
    return _sourceData;
  }

  set sourceData(List<SourceData> value) {
    _sourceData.sort((x, y) => y.timeForSort!.compareTo(x.timeForSort!));
    _sourceData = value;
    notifyListeners();
  }

  // 在前面追加饼并且重新排序一次
  addListInSourceData(List<SourceData> value) {
    sourceData.addAll(value);
    sourceData = sourceData;
  }
}
