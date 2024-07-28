import 'package:dun_cookie_flutter/page/root/logic.dart';
import 'package:get/get.dart';

import '../../request/ceobe/ceobe_request.dart';
import '../../request/cookie/cookie_request.dart';
import '../../route.dart';
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
    state.resourceInfo = await CeobeApi.getResourceInfo();
    state.cookieInfoCount = await CookiesApi.getCookieInfoCount();
    update([state.rootGID]);
  }

  void onTapSetting() {
    Get.toNamed(DunRouter.setting);
  }
}
