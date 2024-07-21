import 'dart:io';

import 'package:dun_cookie_flutter/common/dun_dialog.dart';
import 'package:dun_cookie_flutter/common/package_info.dart';
import 'package:dun_cookie_flutter/manager/dunPreference.dart';
import 'package:dun_cookie_flutter/manager/settingManager.dart';
import 'package:dun_cookie_flutter/model/ceobe/version/dun_app.dart';
import 'package:dun_cookie_flutter/page/root/state.dart';
import 'package:dun_cookie_flutter/request/ceobe/ceobe_request.dart';
import 'package:get/get.dart';

class RootLogic extends GetxController {
  static RootLogic get to => Get.find<RootLogic>();

  final state = RootState();

  @override
  void onInit() {
    super.onInit();
    _checkVersion();
  }

  @override
  void onClose() {
    super.onClose();
    state.scrollHideController.dispose();
  }

  // 判断版本号，强制更新&更新日志
  void _checkVersion() async {
    String nowVersion = SettingManager.getInstance().version;
    DunAppInfoModel? newApp = await CeobeApi.getAppVersionInfo();
    String? lastShowedVersion = getLastShowVersion();
    if (Platform.isIOS) {
      int openNumber = getLaunchCount() ?? 0;
      if (openNumber >= 0) {
        saveLaunchCount(openNumber + 1);
      }
      if (openNumber == 10) {
        showTapStarDialog();
        // 先不用重置 统计一下吧
        // sp.setInt("number_of_openings",-1);
      }
    }
    if (lastShowedVersion != null && nowVersion != lastShowedVersion) {
      DunAppInfoModel? nowApp =
          await CeobeApi.getAppVersionInfo(version: nowVersion);
      if (nowApp != null) {
        showUpdateInfoDialog(nowApp);
      }
    }
    if (newApp != null) {
      if (PackageInfoPlus.isVersionHigher(newApp.version, nowVersion)) {
        showUpdateDialog(
            nowAppVersion: nowVersion, newApp: newApp, isFocus: newApp.force);
      }
    }
  }

  void onTapBottomItem(int index) {
    state.currentPageIndex = index;
    update();
  }
}
