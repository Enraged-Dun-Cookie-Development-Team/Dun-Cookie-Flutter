import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../common/dun_toast.dart';
import '../../common/package_info.dart';
import '../../manager/settingManager.dart';
import '../../model/ceobe/version/dun_app.dart';
import '../../request/ceobe/ceobe_request.dart';
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
    var responseData = await CeobeApi.getAppVersionInfo();
    if (!responseData.error) {
      DunAppInfoModel? app = responseData.data;
      if (PackageInfoPlus.isVersionHigher(app?.version, state.version.value)) {
        //跳转更新
        DunToast.showInfo("当前版本已过时，为您跳转到更新页面");
        Get.toNamed(DunRouter.update, arguments: app);
      } else {
        DunToast.showSuccess("当前版本是最新版本");
      }
    }
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
