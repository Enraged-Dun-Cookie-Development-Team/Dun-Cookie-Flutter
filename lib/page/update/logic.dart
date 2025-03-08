import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import '../../services/update_service.dart';
import 'state.dart';

class UpdateLogic extends GetxController {
  final UpdateState state = UpdateState();

  void onTapDownload() async {
    UpdateService.to?.onTapDownload();
  }

  void cancelDownload() {
    UpdateService.to?.cancelDownload();
  }

  void jumpExternalWeb(String url) {
    DunJump.openExternalWeb(url);
  }

  void jumpAppStore() {
    DunJump.openAppUrlScheme(
      "https://apps.apple.com/cn/app/id1629917304",
    );
  }

  void installApp() {
    UpdateService.to?.installApp();
  }

  void onTapBack() {
    if (state.isForce) {
      DunToast.showInfo("这波啊，是强制更新");
    } else {
      Get.back();
    }
  }

  Future<bool> onWillBack() async {
    if (state.isForce) {
      DunToast.showInfo("这波啊，是强制更新");
      return false;
    } else {
      return true;
    }
  }
}
