import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/user_settings.dart';
import 'package:flutter/cupertino.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider();

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
    notifyListeners();
  }

  saveRid(rid) {
    _settingData.rid = rid;
    saveAppSetting();
  }

  saveIsPreview(isPreview) {
    _settingData.isPreview = isPreview;
    saveAppSetting();
  }

  saveDatasourceSetting(UserDatasourceSettings datasourceSetting) {
    _settingData.datasourceSetting = datasourceSetting;
    saveAppSetting();
  }

  saveAppSetting() {
    DunPreferences()
        .saveString(key: "settingData", value: settingDataToJson(_settingData));
    notifyListeners();
  }

  readAppSetting() async {
    String data = await DunPreferences().getString(key: "settingData");
    if (data != "") {
      _settingData = settingDataFromJson(data);
      notifyListeners();
    }
  }
}
