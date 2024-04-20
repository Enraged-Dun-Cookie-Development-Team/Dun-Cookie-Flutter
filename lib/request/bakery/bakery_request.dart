import 'dart:convert';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/request/request.dart';

import '../respond.dart';

class BakeryRequest {

  /// 请求测试饼组数据
  static Future<BakeryData> getTestBakeryInfo() async {
    //print("请求测试饼组数据");
    ResponseData response = await HttpClass.get(UrlString.testBakeryInfoUrl,
        type: RequestType.server);
    if (response.error) {
      return BakeryData();
    } else {
      return BakeryData.fromJson(response.data);
    }
  }

  /// 请求饼组ID列表
  static Future<List<String>> getBakeryMansionIdList() async {
    //print("请求饼组ID列表");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryMansionIdListUrl,
        type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      jsonDecode(response.data);
      if (response.data["data"] != null) {
        return response.data["data"].cast<String>();
      } else {
        return [];
      }
    }
  }

  /// 根据ID请求饼组数据
  static Future<BakeryData> getBakeryInfo(id) async {
    //print("根据ID请求饼组数据");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryMansionInfoUrl(id),
        type: RequestType.server);
    if (response.error) {
      return BakeryData();
    } else {
      return BakeryData.fromJson(response.data['data']);
    }
  }

  /// 获取蜜饼工坊最近一次预测信息
  static Future<BakeryRecentPredictModel?> getBakeryRecentPredict() async {
    //print("获取蜜饼工坊最近一次预测信息");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryRecentPredictUrl,
        type: RequestType.server);
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
