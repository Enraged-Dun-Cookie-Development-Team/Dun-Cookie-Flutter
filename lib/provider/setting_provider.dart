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
        shortcutList: ["企鹅物流"],
        notOnce: true);
  }
}
