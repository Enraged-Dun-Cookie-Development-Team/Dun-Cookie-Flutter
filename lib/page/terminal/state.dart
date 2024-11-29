import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/ceobe/resource/resource_info.dart';
import '../../model/cookie/cookie_count.dart';

class TerminalState {
  Rx<ResourceInfoModel> resourceInfo = ResourceInfoModel.fromJson({}).obs;
  Rx<CookieInfoCountModel> cookieInfoCount =
      CookieInfoCountModel.fromJson({}).obs;
  String rootGID = 'root';
  final pageScrollController = ScrollController();

  TerminalState() {
    ///Initialize variables
  }
}
