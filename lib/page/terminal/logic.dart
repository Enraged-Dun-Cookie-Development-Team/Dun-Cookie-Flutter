import 'package:get/get.dart';

import '../../request/ceobe/ceobe_request.dart';
import '../../request/cookie/cookie_request.dart';
import '../../route.dart';
import '../root/logic.dart';
import 'state.dart';

class TerminalLogic extends GetxController {
  final TerminalState state = TerminalState();

  @override
  void onInit() {
    super.onInit();
    RootLogic.to?.state.scrollHideController
        .addScrollController(state.pageScrollController);
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
    state.pageScrollController.dispose();
  }

  Future<void> loadData() async {
    await CeobeApi.getResourceInfo().then((value) {
      if (!value.error && value.data != null) {
        state.resourceInfo.value = value.data!;
      }
    });
    CookiesApi.getCookieInfoCount().then((value) {
      if (!value.error && value.data != null) {
        state.cookieInfoCount.value = value.data!;
      }
    });
    update([state.rootGID]);
  }

  void onTapSetting() {
    Get.toNamed(DunRouter.setting);
  }
}
