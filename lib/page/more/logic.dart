import 'package:dun_cookie_flutter/page/root/logic.dart';
import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../model/ceobe/tool/tool.dart';
import '../../model/ceobe/video/video.dart';
import '../../request/bakery/bakery_request.dart';
import '../../request/ceobe/ceobe_request.dart';
import '../../request/manga/manga_request.dart';
import '../../route.dart';
import 'state.dart';

class MoreLogic extends GetxController {
  final MoreState state = MoreState();

  @override
  void onInit() {
    super.onInit();
    RootLogic.to?.state.scrollHideController
        .addScrollController(state.pageScrollController);
    loadData().then((value) {
      update();
    });
  }

  @override
  void onClose() {
    super.onClose();
    state.pageScrollController.dispose();
  }

  Future<void> loadData() async {
    MangaApi.getTerraNewestEpisode().then((value) {
      if (!value.error && value.data != null) {
        state.terraRecentEpisode.value = value.data!;
      }
    });
    CeobeApi.getVideoInfo().then((value) {
      if (!value.error) {
        state.videoList.addAll(value.data ?? []);
      }
    });
    CeobeApi.getQuickJumpInfo().then((value) {
      if (!value.error) {
        state.quickJumpList.addAll(value.data ?? []);
      }
    });
    BakeryApi.getBakeryRecentPredict().then((value) {
      if (!value.error && value.data != null) {
        state.bakeryRecentPredict.value = value.data!;
      }
    });
  }

  void onTapManga() {
    Get.toNamed(DunRouter.manga);
  }

  void onTapHoneyCakeWorkshop() {
    Get.toNamed(DunRouter.honeyCake);
  }

  void onTapToolLink(ToolModel quickJump) {
    DunJump.openWebPage(quickJump.url);
  }

  void onTapVideoLink(VideoModel video) {
    var infoList = video.url.split("video/");
    if (infoList.length > 1) {
      String appUrl = "bilibili://video/${infoList[1]}";
      DunJump.openAppOrWebPage(url: video.url, appUrlScheme: appUrl);
    }
  }
}
