import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/user_settings.dart';
import 'package:dun_cookie_flutter/request/request.dart';

import '../respond.dart';


class InfoRequest {
  /// APP版本
  static Future<DunApp> getAppVersionInfo({String? version}) async {
    Map<String, dynamic> params = {};
    if (version != null) {
      params["version"] = version;
    }
    ResponseData response = await HttpClass.get(UrlString.appVersionUrl,
        params: params, type: RequestType.server);
    if (response.data != null) {
      return DunApp.fromJson(response.data?["data"]);
    }
    return Future.value(DunApp());
  }

  /// 创建新用户
  static Future<bool> createUser(String? mobId) async {
    ResponseData response = await HttpClass.post(UrlString.createUserUrl,
        data: {"mob_id": mobId}, type: RequestType.server);

    String code = response.data.data["code"];

    return response.isSuccess || code == "C0018";
  }

  /// 根据mobId获取用户数据源配置
  static Future<UserDatasourceSettings> getUserDatasourceSettings() async {
    ResponseData response = await HttpClass.get(
        UrlString.userDatasourceSettingsUrl,
        type: RequestType.server);
    if (response.data != null) {
      return UserDatasourceSettings.fromJson(response.data?["data"]);
    }
    return Future.value(UserDatasourceSettings());
  }
}
