import 'dart:math';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class BakeryRequest {
  static _getBakeryInfo() async {
    final url = "/canteen/workshop?${Random().nextInt(100000).toString()}";
    print("请求饼组数据");
    return await HttpClass.get(url, type: 2);
  }

  static Future<BakeryData> getBakeryInfo() async {
    ResponseData response = await _getBakeryInfo();
    if (response.error) {
      return BakeryData();
    } else {
      return BakeryData.fromJson(response.data);
    }
  }
}
