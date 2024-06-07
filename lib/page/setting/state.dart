import 'package:get/get.dart';

class SettingState {
  RxString version = '0.0.0'.obs;
  RxBool isPreview = false.obs;
  RxString mobRId = ''.obs;
  final String record = "闽ICP备2021013932号-2A";

  SettingState() {
    ///Initialize variables
  }
}
