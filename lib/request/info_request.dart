import 'dart:math';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class InfoRequest {
  static _getCeobecanteenInfo() async {
    final url ="/canteen/info?${Random().nextInt(100000).toString()}";
    print("请求info数据");
    return await HttpClass.get(url,type: 2);
  }

  static Future<CeobecanteenData> getCeobecanteenInfo() async {
    ResponseData response = await _getCeobecanteenInfo();
    if (response.error) {
      return CeobecanteenData();
    } else {
      return CeobecanteenData.fromJson(response.data);
    }
  }
}