import 'dart:io';

import 'package:dun_cookie_flutter/page/update/logic.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import '../../manager/settingManager.dart';
import '../../route.dart';
import 'state.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  @override
  void onInit() {
    super.onInit();
    state.version.value = SettingManager.getInstance().version;
    state.isPreview.value = SettingManager.getInstance().isPreview;
    state.isHideBottomOnScroll.value =
        SettingManager.getInstance().isHideBottomOnScroll;
    state.mobRId.value = SettingManager.getInstance().rid;
  }

  void onTapBack() {
    Get.back();
  }

  void onTapDataSourceSetting() {
    Get.toNamed(DunRouter.datasourceSetting);
  }

  void onTapPreviewSwitch(bool value) {
    state.isPreview.value = value;
    SettingManager.getInstance().isPreview = value;
  }

  void onTapHideBottomOnScrollSwitch(bool value) {
    state.isHideBottomOnScroll.value = value;
    SettingManager.getInstance().isHideBottomOnScroll = value;
  }

  void onTapAboutUs() {
    DunJump.openQQGroup();
  }

  void onTapFollowOnBilibili() {
    DunJump.followInBilibili();
  }

  Future<void> onTapCheckUpgrade() async {
    UpdateLogic.to?.checkLatestVersion();
  }

  Future<void> onTapDonation() async {
    //网页跳转
    if (Platform.isIOS) {
      String nowVersion = SettingManager.getInstance().version;
      print(
          "https://www.ceobecanteen.top/?version=$nowVersion&position=mo-sponsor");
      DunJump.openWebPage(
        "https://www.ceobecanteen.top/?version=$nowVersion&position=mo-sponsor",
      );
    } else {
      DunJump.openWebPage("https://www.ceobecanteen.top/?&position=mo-sponsor");
    }
  }

  void onTapMobId() {
    Clipboard.setData(ClipboardData(text: state.mobRId.value));
    DunToast.showSuccess("已复制");
  }

  void onTapRecord() {
    Clipboard.setData(ClipboardData(text: state.record));
    DunJump.openWebPage('https://beian.miit.gov.cn/');
  }
}
