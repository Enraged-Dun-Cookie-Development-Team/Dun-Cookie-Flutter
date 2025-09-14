import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manager/dun_preference.dart';
import '../model/ceobe/version/dun_app.dart';
import '../route.dart';
import '../widget/dialog/tap_star_dialog.dart';
import '../widget/dialog/update_info_dialog.dart';
import '../widget/dialog/loading_dialog.dart';
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

showLoadingDialog() {
  if (DunObserver.loadingDialogRoute == null) {
    Get.dialog(const LoadingDialog(),
        useSafeArea: false,
        barrierDismissible: false,
        name: DunDialogRoute.loading.name);
  }
}

clearLoadingDialog() {
  Route? loadingDialogRoute = DunObserver.loadingDialogRoute;
  if (loadingDialogRoute != null) {
    Get.removeRoute(loadingDialogRoute);
  }
}
