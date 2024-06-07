import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../model/cookie/cookie_main_list.dart';
import '../../widget/cookie/cookie_content.dart';

class CookieShareState {
  Cookie cookie = Cookie.fromJson({});
  final boundaryKey = GlobalKey();
  Rx<CookieContentType> type = CookieContentType.shared.obs;
  List<CookieImage> selectedImageList = [];

  String rootGID = "rootGID";

  CookieShareState() {
    ///Initialize variables
  }

  List<CookieImage> selectedImage = [];
  List<CookieImage> selectedRetweetedImage = [];
}
