
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
    loadData().then((value) {
      update();
    });
  }

  Future<void> loadData() async {
    state.terraRecentEpisode = await MangaApi.getTerraNewestEpisode();
    state.videoList = await CeobeApi.getVideoInfo();
    state.quickJumpList = await CeobeApi.getQuickJumpInfo();
    state.bakeryRecentPredict = await BakeryApi.getBakeryRecentPredict();
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
