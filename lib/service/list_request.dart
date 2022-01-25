import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';

import 'main.dart';

class ListRequest {

//  处理返回的数据
  static List<SourceData> _responseDataToListData(ResponseData request) {
    if (request.error) {
      return [];
    }
    List<SourceData> resultAll = [];
    List<SourceInfo> sourceLists = SourceList.sourceList;
    for (var sourceInfo in sourceLists) {
      if (request.data["data"][sourceInfo.dataName] == null) {
        continue;
      }
      List<dynamic> info = request.data["data"][sourceInfo.dataName];
      for (var e in info) {
        e["sourceInfo"] = sourceInfo;
        resultAll.add(SourceData.fromJson(e));
      }
    }
    return resultAll;
  }

//  查询方法
  static _canteenOriginalCardList({Map<String, String>? source}) async {
    const url = "/canteen/cardList";
    ResponseData request = await HttpClass.get(url, params: source);
    print("请求一次全部数据");
    return request;
  }

  //  请求全部
  static Future<List<SourceData>> canteenCardList(
      {Map<String, String>? source}) async {
    if (source?["source"]?.length == 0) {
      // return ResponseData(false, [], "没有传入参数");
      return [];
    }
    ResponseData data =
        await ListRequest._canteenOriginalCardList(source: source);
    return _responseDataToListData(data);
  }

//  请求新的饼
  static Future<List<SourceData>> canteenNewCardList() async {
    const url = "/canteen/newCardList";
    List<SourceData> resultAll = [];
    ResponseData request = await HttpClass.get(url);
    print("请求一次新数据");
    if (request.error) {
      DunToast.showError(request.msg);
      return resultAll;
    } else {
      return _responseDataToListData(request);
    }
  }
}
