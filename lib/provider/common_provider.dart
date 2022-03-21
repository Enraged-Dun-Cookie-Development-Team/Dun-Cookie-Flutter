import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:flutter/material.dart';

class CommonProvider with ChangeNotifier {
  CommonProvider();

  // 路由初始化页面
  int _routerIndex = Constant.starRouterIndex;

  int get routerIndex {
    return _routerIndex;
  }

  setRouterIndex(index) {
    _routerIndex = index;
    eventBus.fire(ChangeThemeBus(index));
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

  void setCheckListInPriority(priority, isAdd) {
    if (isAdd) {
      _checkSource.add(priority);
    } else {
      _checkSource.remove(priority);
    }
    checkSource = _checkSource;
    // 保存记录
    DunPreferences()
        .saveStringList(key: "listCheckSource", value: _checkSource);
  }

//  获取到的列表数据
  List<SourceData>? _sourceData;

  List<SourceData>? get sourceData {
    return _sourceData;
  }

  set sourceData(List<SourceData>? value) {
    _sourceData = value;
    if (_sourceData != null) {
      _sourceData!.sort((x, y) => y.timeForSort!.compareTo(x.timeForSort!));
    }
    notifyListeners();
  }

  // 在前面追加饼并且重新排序一次
  addListInSourceData(List<SourceData> value) {
    _sourceData ??= [];
    _sourceData!.addAll(value);
    sourceData = _sourceData;
  }

//  获取到的蜜饼工坊数据
  List<BakeryData> _bakeryData = [];

  List<BakeryData> get bakeryData => _bakeryData;

  set bakeryData(List<BakeryData> value) {
    _bakeryData = value;
    notifyListeners();
  }

  // 在前面追加饼并且重新排序一次
  addListInBakeryData(value) {
    _bakeryData.insert(0, value);
    bakeryData = _bakeryData;
  }
}
