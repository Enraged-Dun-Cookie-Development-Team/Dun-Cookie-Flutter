import 'dart:convert';

import 'package:duncookie/model/info/setting_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/info/user_settings.dart';

String _$NotOnce = 'notOnce';
String _$Rid = 'rid';
String _$IsPreview = 'isPreview';
String _$IsHideBottomOnScroll = 'isHideBottomOnScroll';
String _$DatasourceSetting = "datasourceSetting";
String _$LastShowVersion = 'lastShowVersion';
String _$LaunchCount = 'launchCount';
String _$MangaHistory = "mangaHistory";
String _$SettingData = "settingData";

class DunPreferences {
  static final _instance = DunPreferences._();

  DunPreferences._();

  static DunPreferences get instance => _instance;

  late final SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  Future<bool> saveDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }

  Future<bool> saveBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }

  Future<bool> saveString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<bool> saveStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  Future<bool> delete(String key) {
    return _prefs.remove(key);
  }
}

Future<bool> saveLastShowVersion(String value) async {
  return await DunPreferences.instance.saveString(_$LastShowVersion, value);
}

String? getLastShowVersion() {
  return DunPreferences.instance.getString(_$LastShowVersion);
}

Future<bool> saveLaunchCount(int value) async {
  return await DunPreferences.instance.saveInt(_$LaunchCount, value);
}

int? getLaunchCount() {
  return DunPreferences.instance.getInt(_$LaunchCount);
}

Future<bool> saveNotOnce(bool value) async {
  return await DunPreferences.instance.saveBool(_$NotOnce, value);
}

bool? getNotOnce() {
  return DunPreferences.instance.getBool(_$NotOnce);
}

Future<bool> saveRid(String value) async {
  return await DunPreferences.instance.saveString(_$Rid, value);
}

String? getRid() {
  return DunPreferences.instance.getString(_$Rid);
}

Future<bool> saveIsPreview(bool value) async {
  return await DunPreferences.instance.saveBool(_$IsPreview, value);
}

bool? getIsPreview() {
  return DunPreferences.instance.getBool(_$IsPreview);
}

Future<bool> saveIsHideBottomOnScroll(bool value) async {
  return await DunPreferences.instance.saveBool(_$IsHideBottomOnScroll, value);
}

bool? getIsHideBottomOnScroll() {
  return DunPreferences.instance.getBool(_$IsHideBottomOnScroll);
}

Future<bool> saveDatasourceSetting(String value) async {
  return await DunPreferences.instance.saveString(_$DatasourceSetting, value);
}

UserDatasourceModel getDatasourceSetting() {
  String? data = DunPreferences.instance.getString(_$DatasourceSetting);
  if (data != null) {
    return UserDatasourceModel.fromJson(jsonDecode(data));
  } else {
    return UserDatasourceModel.fromJson({});
  }
}

Future<bool> saveMangaHistory(String value) async {
  return await DunPreferences.instance.saveString(_$MangaHistory, value);
}

Map<String, dynamic> getMangaHistory() {
  String? data = DunPreferences.instance.getString(_$MangaHistory);
  if (data != null) {
    return jsonDecode(data);
  }
  return {};
}

Future<bool> saveAppSetting(SettingData value) {
  return DunPreferences.instance
      .saveString(_$SettingData, settingDataToJson(value));
}

Future<SettingData?> readAppSetting() async {
  String? data = DunPreferences.instance.getString(_$SettingData);
  if (data != null) {
    var settingData = settingDataFromJson(data);
    return settingData;
  }
  return null;
}

Future<bool> removeAppSetting() {
  return DunPreferences.instance.delete(_$SettingData);
}
