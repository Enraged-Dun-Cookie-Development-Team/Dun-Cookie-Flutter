import 'package:get/get.dart';

import '../manager/dunPreference.dart';
import '../model/ceobe/version/dun_app.dart';
import '../widget/dialog/TapStarDialog.dart';
import '../widget/dialog/UpdateDialog.dart';
import '../widget/dialog/UpdateInfoDialog.dart';
import '../widget/view_image.dart';

showImageViewDialog(List<String> imageURLList, int initialIndex) async {
  await Get.dialog(
      useSafeArea: false,
      ViewImageExtendedImage(
          imageList: imageURLList, initialIndex: initialIndex),
      name: 'image');
}

showTapStarDialog() async {
  await Get.dialog(const TapStartDialog());
}

showUpdateInfoDialog(DunAppInfoModel nowApp) {
  Get.dialog(UpdateInfoDialog(
    version: nowApp.version,
    description: nowApp.description,
  ));
  saveLastShowVersion(nowApp.version);
}

showUpdateDialog({required String nowAppVersion, required DunAppInfoModel newApp,required bool isFocus}) {
  Get.dialog(
      barrierDismissible: isFocus,
      UpdateDialog(
        oldVersion: nowAppVersion,
        newApp: newApp,
        isFocus: isFocus,
      ));
}
