import 'package:get/get.dart';

import '../../manager/dun_preference.dart';
import '../../services/update_service.dart';
import 'state.dart';

class RootLogic extends GetxController {
  static RootLogic? get to =>
      Get.isRegistered<RootLogic>() ? Get.find<RootLogic>() : null;

  final state = RootState();
  bool get isFirstLaunch => state.launchCount == 1;
  bool get isNotFirstLaunch => !isFirstLaunch;

  @override
  void onInit() {
    super.onInit();
    state.launchCount = (getLaunchCount() ?? 0) + 1;
    saveLaunchCount(state.launchCount);
    UpdateService.to?.checkLatestVersion(autoCheck: true);
  }

  @override
  void onClose() {
    super.onClose();
    state.scrollHideController.dispose();
  }

  void onTapBottomItem(int index) {
    state.currentPageIndex = index;
    update();
  }
}
