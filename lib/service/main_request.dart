import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';

import 'main.dart';

class MainRequest {
  static _canteenOriginalCardList() async {
    const url = "/canteen/cardList";
    var request = await HttpClass.get(url);
    var data = request['data'];
    return data;
  }

  static Future canteenCardListInType(List<int> typeList) async {
    List<SourceData> data = await MainRequest.canteenCardListAll();
    List<SourceData> resultInType = [];
    typeList.forEach((element) => resultInType
        .addAll(data.where((x) => x.sourceInfo.priority == 0).toList()));
    return resultInType;
  }

  static Future canteenCardListAll() async {
    var data = await MainRequest._canteenOriginalCardList();
    var sourceLists = SourceList.getSourceList();
    var resultJson = [];
    sourceLists.forEach((sourceList) {
      var info = data[sourceList["data"]["dataName"]];
      info.forEach((e) => e["sourceInfo"] = sourceList["data"]);
      resultJson.addAll(info);
    });
    List<SourceData> resultAll = [];
    resultJson
        .forEach((element) => resultAll.add(SourceData.fromJson(element)));
    resultAll.sort((x, y) => y.timeForSort.compareTo(x.timeForSort));
    return resultAll;
  }
}
