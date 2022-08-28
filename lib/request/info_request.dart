import 'dart:math';

import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class InfoRequest {
  static _getCeobecanteenInfo() async {
    final url = "/canteen/info?${Random().nextInt(100000).toString()}";
    print("请求info数据");
    return await HttpClass.get(url, type: 2);
  }

  static Future<CeobecanteenData> getCeobecanteenInfo() async {
    ResponseData response = await _getCeobecanteenInfo();
    if (response.error) {
      return CeobecanteenData();
    } else {
      return CeobecanteenData.fromJson(response.data);
    }
  }

  /// APP版本
  static String appVersionUrl = "/canteen/operate/version/app";
  static Future<DunApp>? getAppVersionInfo({String? version}) async {
    Map<String, dynamic> params = {};
    if (version != null) {
      params["version"] = version;
    }
    ResponseData response =
        await HttpClass.get(appVersionUrl, params: params, type: 1);
    return DunApp.fromJson(response.data["data"]);
  }
}
