import 'package:dun_cookie_flutter/manager/settingManager.dart';
import 'package:dun_cookie_flutter/model/ceobe/version/dun_app.dart';
import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import 'state.dart';

class UpdateLogic extends GetxController {
  final UpdateState state = UpdateState();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    state.nowVersion = SettingManager.getInstance().version;
    var value = Get.arguments;
    if (value is DunAppInfoModel) {
      state.dunAppInfo = value;
    }
    update([state.rootGID]);
  }

  void onTapDownload(String url, bool isIOS) {
    if (isIOS) {
      DunJump.openAppUrlScheme(
        "https://apps.apple.com/cn/app/id1629917304",
      );
    } else {
      DunJump.openWebPage(url);
    }
  }

  void onTapBack() {
    if (state.isFocus) {
      DunToast.showInfo("这波啊，是强制更新");
    } else {
      Get.back();
    }
  }

  Future<bool> onWillBack() async {
    if (state.isFocus) {
      DunToast.showInfo("这波啊，是强制更新");
      return false;
    } else {
      return true;
    }
  }
}
