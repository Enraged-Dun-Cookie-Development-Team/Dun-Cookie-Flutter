import 'dart:math';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/request/main.dart';

class BakeryRequest {
  static int requestType = 1;

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
    const url = "/canteen/bakery/mansionId";
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
    final url = "/canteen/bakery/mansionInfo?mansion_id=$id";
    print("根据ID请求饼组数据");
    return await HttpClass.get(url, type: requestType);
  }

  static Future<BakeryData> getBakeryInfo(id) async {
    ResponseData response = await _getBakeryMansionInfo(id);
    if (response.error) {
      return BakeryData();
    } else {
      return BakeryData.fromJson(response.data['data']);
    }
  }

  static _getBakeryMansionRecentPredict() async {
    const url = "/canteen/bakery/mansion/recentPredict";
    print("获取饼学大厦最近一次预测信息");
    return await HttpClass.get(url, type: requestType);
  }

  static Future<BakeryRecentPredictModel> getMansionRecentPredict() async {
    ResponseData response = await _getBakeryMansionRecentPredict();
    if (response.error) {
      return BakeryRecentPredictModel();
    } else {
      return BakeryRecentPredictModel.fromJson(response.data['data']);
    }
  }

  /// 蜜饼工坊最近一次预测
  static String bakeryRecentPredictUrl = "/canteen/bakery/mansion/recentPredict";
  static Future<BakeryRecentPredictModel?> getBakeryRecentPredict() async {
    ResponseData response = await HttpClass.get(bakeryRecentPredictUrl, type: 1);
    if (response.error) {
      return BakeryRecentPredictModel();
    } else {
      if (response.data['data'] != null) {
        return BakeryRecentPredictModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    }
  }
}
