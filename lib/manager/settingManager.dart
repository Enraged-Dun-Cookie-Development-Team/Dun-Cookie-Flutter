import 'dart:convert';

import 'package:get/get.dart';

import '../common/package_info.dart';
import 'dunPreference.dart';
import '../model/info/user_settings.dart';

class SettingManager {
  static final _instance = SettingManager._();

  SettingManager._();

  factory SettingManager.getInstance() => _instance;

  String version = '';
  bool _notOnce = true;
  String _rid = "--";
  bool _isPreview = false;
  Rx<UserDatasourceModel> datasourceSetting =
      UserDatasourceModel(datasourceList: {}, datasourceCombId: "").obs;

  init() async {
    version = await PackageInfoPlus.getVersion();
    await _readNotOnce();
    await _readRid();
    await _readIsPreview();
    await _readDatasourceSetting();
  }

  bool get notOnce => _notOnce;

  set notOnce(bool notOnce) {
    _notOnce = notOnce;
    _saveNotOnce();
  }

  _saveNotOnce() {
    saveNotOnce(_notOnce);
  }

  _readNotOnce() {
    _notOnce = getNotOnce() ?? true;
  }

  String get rid => _rid;

  set rid(String rid) {
    _rid = rid;
    _saveRid();
  }

  _saveRid() {
    saveRid(_rid);
  }

  _readRid() {
    rid = getRid() ?? "--";
  }

  bool get isPreview => _isPreview;

  set isPreview(bool value) {
    _isPreview = value;
    _saveIsPreview();
  }

  _saveIsPreview() {
    saveIsPreview(_isPreview);
  }

  _readIsPreview() {
    _isPreview = getIsPreview() ?? false;
  }

  updateDataSource(UserDatasourceModel datasource) {
    datasourceSetting.value = datasource;
    _saveDatasourceSetting();
  }

  _saveDatasourceSetting() {
    String data = jsonEncode(datasourceSetting.value.toJson());
    saveDatasourceSetting(data);
  }

  _readDatasourceSetting() {
    datasourceSetting.value = getDatasourceSetting();
  }
}
