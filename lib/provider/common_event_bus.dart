import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:event_bus/event_bus.dart';

class CommonEventBus {}

EventBus eventBus = EventBus();

class DunShareImageIsShare {
  DunShareImageIsShare(this.dunShareImageIsShare);

  bool dunShareImageIsShare;
}

class DeviceInfoBus {}

class ChangeSourceBus {}

class ChangeThemeBus {
  ChangeThemeBus(this._themeIndex) {
    themeIndex = _themeIndex;
  }

  int _themeIndex;

  int get themeIndex => _themeIndex;

  set themeIndex(int value) {
    if (themeIndex > DunTheme.themeList.length - 1) {
      _themeIndex = 0;
    } else {
      _themeIndex = value;
    }
    // DunPreferences().saveInt(key: "themeName", value: _themeIndex);
  }
}
