import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:flutter/material.dart';

class ListSourceInfoCheckProvider with ChangeNotifier {
  ListSourceInfoCheckProvider();

  List<String> checkSource = [];

  Future getCheckListInPriority() async {
    var _listCheckSource =
        await DunPreferences().getStringList(key: "listCheckSource");
    checkSource = _listCheckSource;
    notifyListeners();
  }

  void setCheckListInPriority(priority, isAdd) async {
    if (isAdd) {
      checkSource.add(priority);
    } else {
      checkSource.removeWhere((element) => element == priority);
    }
    // 保存记录
    DunPreferences().saveStringList(key: "listCheckSource", value: checkSource);
    notifyListeners();
  }
}
