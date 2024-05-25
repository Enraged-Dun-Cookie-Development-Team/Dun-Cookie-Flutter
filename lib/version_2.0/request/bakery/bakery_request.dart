import 'dart:convert';

import 'package:dun_cookie_flutter/request/request.dart';

import '../../model/bakery/bakery_data.dart';
import '../respond.dart';

class BakeryRequest {
  /// 请求测试饼组数据
  static Future<BakeryDataModel?> getTestBakeryInfo() async {
    //print("请求测试饼组数据");
    ResponseData response = await HttpClass.get(UrlString.testBakeryInfoUrl,
        type: RequestType.server);
    if (response.error) {
      return null;
    } else {
      try {
        return BakeryDataModel.fromJson(response.data);
      } catch (e) {
        print(e);
        return null;
      }
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
  static Future<BakeryDataModel?> getBakeryInfo(id) async {
    //print("根据ID请求饼组数据");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryMansionInfoUrl(id),
        type: RequestType.server);
    if (response.error) {
      return null;
    } else {
      try {
        return BakeryDataModel.fromJson(response.data);
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  /// 获取蜜饼工坊最近一次预测信息
  static Future<BakeryRecentPredictModel?> getBakeryRecentPredict() async {
    //print("获取蜜饼工坊最近一次预测信息");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryRecentPredictUrl,
        type: RequestType.server);
    if (response.error) {
      return null;
    } else {
      if (response.data['data'] != null) {
        try {
          return BakeryRecentPredictModel.fromJson(response.data['data']);
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        return null;
      }
    }
  }
}
