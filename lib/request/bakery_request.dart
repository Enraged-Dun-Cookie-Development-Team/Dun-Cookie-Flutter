import 'dart:math';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class BakeryRequest {
  static int requestType = 2;

  static _getTestBakeryInfo() async {
    final url = "/canteen/workshop?${Random().nextInt(100000).toString()}";
    print("请求测试饼组数据");
    return await HttpClass.get(url, type: requestType);
  }

  static Future<BakeryData> getTestBakeryInfo() async {
    ResponseData response = await _getTestBakeryInfo();
    if (response.error) {
      return BakeryData();
    } else {
      return BakeryData.fromJson(response.data);
    }
  }

  static _getBakeryMansionIdList() async {
    // const url = "/canteen/bakery/mansionId";
    const url = "/canteen/mansionId";
    print("请求饼组ID列表");
    return await HttpClass.get(url, type: requestType);
  }

  static Future<List<String>> getBakeryMansionIdList() async {
    ResponseData response = await _getBakeryMansionIdList();
    if (response.error) {
      return [];
    } else {
      return response.data["data"].cast<String>();
    }
  }

  static _getBakeryMansionInfo(id) async {
    // final url = "/canteen/bakery/mansionInfo?mansion_id=$id";
    // final url = "/canteen/mansionInfo?mansion_id=$id";
    // print("根据ID请求饼组数据");
    // return await HttpClass.get(url, type: requestType);
    const url = "http://api.ceobecanteen.top/canteen/mansionInfo2.json";
    print("根据ID请求饼组数据");
    return await HttpClass.get(url, type: -1);
  }

  static Future<BakeryData> getBakeryInfo(id) async {
    ResponseData response = await _getBakeryMansionInfo(id);
    if (response.error) {
      return BakeryData();
    } else {
      return BakeryData.fromJson(response.data['data']);
    }
  }
}
