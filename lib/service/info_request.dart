import 'dart:math';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/service/main.dart';

class InfoRequest {
  static _getCeobecanteenInfo() async {
    final url =
        "http://api.ceobecanteen.top/canteen/info?${Random().nextInt(100).toString()}";
    var request = await HttpClass.tempGet(url);
    if (request["error"]) {
      return;
    } else {
      var data = request['data'];
      return data;
    }
  }

  static Future<CeobecanteenInfo> getCeobecanteenInfo() async {
    var resultJson = await _getCeobecanteenInfo();
    return CeobecanteenInfo.fromJson(resultJson);
  }
}
