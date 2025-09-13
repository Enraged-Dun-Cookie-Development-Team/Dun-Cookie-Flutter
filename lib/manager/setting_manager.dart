import 'dart:convert';

import 'package:duncookie/model/info/setting_data.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../common/package_info.dart';
import '../model/info/user_settings.dart';
import 'dun_preference.dart';

class SettingManager {
  static final _instance = SettingManager._();

  SettingManager._();

  factory SettingManager.getInstance() => _instance;

  String version = '';
  bool _notOnce = true;
  String _rid = "--";
  bool _isPreview = false;
  bool _isHideBottomOnScroll = false;
  Rx<UserDatasourceModel> datasourceSetting =
      UserDatasourceModel(datasourceList: {}, datasourceCombId: "").obs;
  RxMap<String, String> mangaHistory = RxMap();

  init() async {
    version = await PackageInfoPlus.getVersion();
    await Future.value([
      _readNotOnce(),
      _readRid(),
      _readIsPreview(),
      _readIsHideBottomOnScroll(),
      _readDatasourceSetting(),
      _readMangaHistory(),
    ]);
    var setting = await readAppSetting();
    if (setting != null) {
      changeSave(setting);
    }
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

  bool get isHideBottomOnScroll => _isHideBottomOnScroll;

  set isHideBottomOnScroll(bool value) {
    _isHideBottomOnScroll = value;
    _saveIsHideBottomOnScroll();
  }

  _saveIsHideBottomOnScroll() {
    saveIsHideBottomOnScroll(_isHideBottomOnScroll);
  }

  _readIsHideBottomOnScroll() {
    _isHideBottomOnScroll = getIsHideBottomOnScroll() ?? true;
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

  addMangaHistory(String comic, String episode) {
    mangaHistory[comic] = episode;
    _saveMangaHistory();
  }

  _saveMangaHistory() {
    String data = jsonEncode(mangaHistory);
    saveMangaHistory(data);
  }

  _readMangaHistory() {
    var data = getMangaHistory();
    mangaHistory.value =
        data.map((key, value) => MapEntry(key, value.toString()));
  }

  changeSave(SettingData setting) {
    isPreview = setting.isPreview ?? _isPreview;
    notOnce = setting.notOnce ?? _notOnce;
    rid = setting.rid ?? _rid;
    updateDataSource(setting.datasourceSetting ?? datasourceSetting.value);
    removeAppSetting();
  }
}
