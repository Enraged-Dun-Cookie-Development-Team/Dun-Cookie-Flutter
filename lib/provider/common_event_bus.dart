import 'package:dun_cookie_flutter/common/persistence/main.dart';
import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class CommonEventBus {}

EventBus eventBus = EventBus();

class DunShareImageIsShare {
  DunShareImageIsShare(this.dunShareImageIsShare);

  bool dunShareImageIsShare;
}

class ChangeSourceBus {}

class ChangeMenu {}

class UpdatePrivacyPermissionStatus {}

class ChangePopupMenuDownButton {
  ChangePopupMenuDownButton({this.idList, this.checkId});

  List<String>? idList;
  String? checkId;
}

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
