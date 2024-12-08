
import 'package:dun_cookie_flutter/manager/dunPreference.dart';
import 'package:dun_cookie_flutter/page/root/state.dart';
import 'package:dun_cookie_flutter/page/update/logic.dart';
import 'package:get/get.dart';

class RootLogic extends GetxController {
  static RootLogic? get to =>
      Get.isRegistered<RootLogic>() ? Get.find<RootLogic>() : null;

  final state = RootState();

  @override
  void onInit() {
    super.onInit();
    _increaseLaunchCount();
    UpdateLogic.to?.checkLatestVersion(autoCheck: true);
  }

  @override
  void onClose() {
    super.onClose();
    state.scrollHideController.dispose();
  }

  void _increaseLaunchCount() {
    saveLaunchCount((getLaunchCount() ?? 0) + 1);
  }

  void onTapBottomItem(int index) {
    state.currentPageIndex = index;
    update();
  }
}
