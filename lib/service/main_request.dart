import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class MainRequest {
  static _canteenOriginalCardList({Map<String, String>? source}) async {
    const url = "/canteen/cardList";
    ResponseData request = await HttpClass.get(url, params: source);
    print("请求一次全部数据");
    return request;
  }

  static Future<List<SourceData>> canteenCardList(
      {Map<String, String>? source}) async {
    List<SourceData> resultAll = [];
    if (source?["source"]?.length == 0) {
      // return ResponseData(false, [], "没有传入参数");
      return [];
    }
    ResponseData data =
        await MainRequest._canteenOriginalCardList(source: source);
    if (data.error) {
      return [];
    }
    List<SourceInfo> sourceLists = SourceList.sourceList;
    for (var sourceInfo in sourceLists) {
      if (data.data["data"][sourceInfo.dataName] == null) {
        continue;
      }
      List<dynamic> info = data.data["data"][sourceInfo.dataName];
      for (var e in info) {
        e["sourceInfo"] = sourceInfo;
        resultAll.add(SourceData.fromJson(e));
      }
    }
    resultAll.sort((x, y) => y.timeForSort!.compareTo(x.timeForSort!));
    return resultAll;
  }

  static Future<List<SourceData>> canteenNewCardList() async {
    const url = "/canteen/newCardList";
    List<SourceData> resultAll = [];
    ResponseData request = await HttpClass.get(url);
    if (request.error) {
      DunToast.showError(request.msg);
      return resultAll;
    } else {
      var data = request.data['data'];
      return data;
    }
  }
}
