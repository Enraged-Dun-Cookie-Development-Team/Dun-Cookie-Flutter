import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/user_settings.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class InfoRequest {
  /// APP版本
  static const String _appVersionUrl = "/canteen/operate/version/app";

  static Future<DunApp> getAppVersionInfo({String? version}) async {
    Map<String, dynamic> params = {};
    if (version != null) {
      params["version"] = version;
    }
    ResponseData response =
        await HttpClass.get(_appVersionUrl, params: params, type: 1);
    if (response.data != null) {
      return DunApp.fromJson(response.data?["data"]);
    }
    return Future.value(DunApp());
  }

  static const String _createUserUrl = "/canteen/user/createUser";

  static Future<bool> createUser(String? mobId) async {
    ResponseData res =
        await HttpClass.post(_createUserUrl, data: {"mob_id": mobId}, type: 1);

    String code = res.data.data["code"];

    return res.isSuccess() || code == "C0018";
  }

  /// 根据mobId获取用户数据源配置
  static const String _userDatasourceSettingsUrl =
      "/canteen/user/datasourceConfig";

  static Future<UserDatasourceSettings> getUserDatasourceSettings() async {
    ResponseData response =
        await HttpClass.get(_userDatasourceSettingsUrl, type: 1);
    if (response.data != null) {
      return UserDatasourceSettings.fromJson(response.data?["data"]);
    }
    return Future.value(UserDatasourceSettings());
  }
}
