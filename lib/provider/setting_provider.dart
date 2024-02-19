import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/user_settings.dart';
import 'package:flutter/cupertino.dart';

class SettingProvider with ChangeNotifier {
  static final _instance = SettingProvider._();

  SettingProvider._();

  /// Get a global instance of [SettingsProvider].
  ///
  /// Never use it anywhere expect [main.dart], where we put it into a [ChangeNotifierProvider] on the top
  /// of widget tree.
  /// If you need to get access to a [SettingsProvider], call [context.read<SettingsProvider>()] instead.
  factory SettingProvider.getInstance() => _instance;

  SettingData _settingData = SettingData(
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
      isPreview: false,
      shortcutList: [],
      notOnce: true,
      rid: "--",
      darkMode: 0,
      datasourceSetting: null
  );

  SettingData get appSetting {
    return _settingData;
  }

  set appSetting(SettingData settingData) {
    _settingData = settingData;
    saveAppSetting();
    print("设置appSetting");
  }

  saveRid(rid) {
    _settingData.rid = rid;
    print("保存rid");
  }

  saveIsPreview(isPreview) {
    _settingData.isPreview = isPreview;
    print("保存isPreview");
  }

  saveDatasourceSetting(UserDatasourceSettings datasourceSetting) {
    _settingData.datasourceSetting = datasourceSetting;
    print("保存datasourceSetting");
  }

  saveAppSetting() {
    DunPreferences()
        .saveString(key: "settingData", value: settingDataToJson(_settingData));
    notifyListeners();
    print("保存设置");
  }

  readAppSetting() async {
    String data = await DunPreferences().getString(key: "settingData");
    if (data != "") {
      _settingData = settingDataFromJson(data);
    }
    notifyListeners();
    print("读取设置");
  }

  flash(){
    notifyListeners();
    print("刷新设置");
  }
}
