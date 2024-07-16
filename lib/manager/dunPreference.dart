import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/info/user_settings.dart';

String _$NotOnce = 'notOnce';
String _$Rid = 'rid';
String _$IsPreview = 'isPreview';
String _$DatasourceSetting = "datasourceSetting";
String _$LastShowVersion = 'lastShowVersion';
String _$LaunchCount = 'launchCount';

class DunPreferences {
  static final _instance = DunPreferences._();

  DunPreferences._();

  factory DunPreferences.getInstance() => _instance;

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
}

Future<bool> saveLastShowVersion(String value) async {
  return await DunPreferences.getInstance().saveString(_$LastShowVersion, value);
}

String? getLastShowVersion(){
  return DunPreferences.getInstance().getString(_$LastShowVersion);
}

Future<bool> saveLaunchCount(int value) async {
  return await DunPreferences.getInstance().saveInt(_$LaunchCount, value);
}

int? getLaunchCount(){
  return DunPreferences.getInstance().getInt(_$LaunchCount);
}

Future<bool> saveNotOnce(bool value) async {
  return await DunPreferences.getInstance().saveBool(_$NotOnce, value);
}

bool? getNotOnce() {
  return DunPreferences.getInstance().getBool(_$NotOnce);
}

Future<bool> saveRid(String value) async {
  return await DunPreferences.getInstance().saveString(_$Rid, value);
}

String? getRid() {
  return DunPreferences.getInstance().getString(_$Rid);
}

Future<bool> saveIsPreview(bool value) async {
  return await DunPreferences.getInstance().saveBool(_$IsPreview, value);
}

bool? getIsPreview() {
  return DunPreferences.getInstance().getBool(_$IsPreview);
}

Future<bool> saveDatasourceSetting(String value) async {
  return await DunPreferences.getInstance()
      .saveString(_$DatasourceSetting, value);
}

UserDatasourceModel getDatasourceSetting() {
  String? data = DunPreferences.getInstance().getString(_$DatasourceSetting);
  if (data != null) {
    return UserDatasourceModel.fromJson(jsonDecode(data));
  } else {
    return UserDatasourceModel.fromJson({});
  }
}
