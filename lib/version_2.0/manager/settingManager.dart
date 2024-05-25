import 'package:dun_cookie_flutter/version_2.0/model/info/user_settings.dart';
import 'package:get/get.dart';

import '../../common/persistence/main.dart';

class SettingManager {
  static final _instance = SettingManager._();

  SettingManager._();

  factory SettingManager.getInstance() => _instance;

  RxBool notOnce = true.obs;
  RxString rid = "--".obs;
  RxBool isPreview = false.obs;
  Rx<DatasourceModel> datasourceSetting =
      DatasourceModel(datasourceList: [], datasourceCombId: "").obs;

  updateNotOnce(bool notOnce) {
    this.notOnce.value = notOnce;
    saveNotOnce();
  }

  saveNotOnce() {
    DunPreferences().saveBool(key: "notOnce", value: notOnce.value);
  }

  readNotOnce() async {
    bool? value = await DunPreferences().getBool(key: "notOnce");
    notOnce.value = value ?? true;
  }

  updateRid(String rid) {
    this.rid.value = rid;
    saveRid();
  }

  saveRid() {
    DunPreferences().saveString(key: "rid", value: rid.value);
  }

  readRid() async {
    String? value = await DunPreferences().getString(key: "notOnce");
    rid.value = value ?? "--";
  }

  updateIsPreview(bool isPreview) {
    this.isPreview.value = isPreview;
    saveIsPreview();
  }

  saveIsPreview() {
    DunPreferences().saveBool(key: "isPreview", value: isPreview.value);
  }

  readIsPreview() async {
    bool? value = await DunPreferences().getBool(key: "isPreview");
    isPreview.value = value ?? false;
  }

  updateDataSource(DatasourceModel datasource) {}
}
