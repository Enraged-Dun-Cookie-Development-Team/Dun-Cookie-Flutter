import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:flutter/cupertino.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider();

  late SettingData _settingData;

  SettingData get appSetting {
    return _settingData;
  }

  set appSetting(SettingData settingData) {
    _settingData = settingData;
    saveAppSetting();
    notifyListeners();
  }

  saveAppSetting() {
    DunPreferences()
        .saveString(key: "settingData", value: settingDataToJson(_settingData));
    notifyListeners();
  }

  readAppSetting() async {
    String data = await DunPreferences().getString(key: "settingData");
    if (data == "") {
      initAppSetting();
    } else {
      _settingData = settingDataFromJson(data);
    }
  }

  initAppSetting() {
    _settingData = SettingData(
        checkSource: [
          "0",
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          "10",
          "11"
        ],
        isPreview: true,
        shortcutList: [],
        notOnce: true);
  }

// // 设置 - 饼来源
// List<String> _checkSource = [];
//
// List<String> get checkSource {
//   return _checkSource;
// }
//
// set checkSource(List<String> value) {
//   _checkSource = value;
//   notifyListeners();
// }
//
// Future readCheckSource() async {
//   List<String> value = await DunPreferences().getStringList(key: "listCheckSource");
//   if (value != null && value.length > 0) {
//     checkSource = value;
//   } else {
//     checkSource = [
//       "0",
//       "1",
//       "2",
//       "3",
//       "4",
//       "5",
//       "6",
//       "7",
//       "8",
//       "9",
//       "10",
//       "11"
//     ];
//   }
// }
//
// void saveCheckSource(priority, isAdd) {
//   if (isAdd) {
//     _checkSource.add(priority);
//   } else {
//     _checkSource.remove(priority);
//   }
//   notifyListeners();
//   // 保存记录
//   DunPreferences()
//       .saveStringList(key: "listCheckSource", value: _checkSource);
// }
//
// // 设置 - 省流模式
// bool _isPreview = false;
//
// set isPreview(bool value) {
//   _isPreview = value;
//   savePreview();
//   notifyListeners();
// }
//
// bool get isPreview {
//   return _isPreview;
// }
//
// readPreview() async {
//   _isPreview = await DunPreferences().getBool(key: "imagePreview");
// }
//
// savePreview() {
//   DunPreferences().saveBool(key: "imagePreview", value: _isPreview);
// }
//
// // 设置 - 快捷方式
// List<String> _shortcutList = [];
//
// set shortcutList(List<String> value) {
//   _shortcutList = value;
//   saveShortcutList();
//   notifyListeners();
// }
//
// List<String> get shortcutList {
//   return _shortcutList;
// }
//
// readShortcutList() async {
//   _shortcutList = await DunPreferences().getStringList(key: "shortcutList");
// }
//
// saveShortcutList() {
//   DunPreferences().saveBool(key: "shortcutList", value: _shortcutList);
// }
}
