import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebState {
  String url = "";
  RxString title = "".obs;
  WebViewController? webController;
  bool finish = false;

  WebState() {
    ///Initialize variables
  }
}
