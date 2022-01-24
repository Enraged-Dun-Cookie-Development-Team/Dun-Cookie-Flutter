import 'dart:math';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/service/main.dart';

class InfoRequest {
  static _getCeobecanteenInfo() async {
    final url =
        "http://api.ceobecanteen.top/canteen/info?${Random().nextInt(100000).toString()}";
    print("请求info数据");
    return await HttpClass.tempGet(url);
  }

  static Future<CeobecanteenInfo> getCeobecanteenInfo() async {
    var resultMap = await _getCeobecanteenInfo();
    if (resultMap["error"]) {
      return CeobecanteenInfo();
    } else {
      return CeobecanteenInfo.fromJson(resultMap["data"]);
    }
  }
}
