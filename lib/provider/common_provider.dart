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
    notifyListeners();
    // eventBus.fire(ChangeThemeBus(index));
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
  BakeryData _bakeryData = BakeryData();

  BakeryData get bakeryData => _bakeryData;

  set bakeryData(BakeryData value) {
    _bakeryData = value;
    notifyListeners();
  }

  // 在前面追加饼并且重新排序一次
  addListInBakeryData(value) {
    bakeryData = _bakeryData;
  }
}
