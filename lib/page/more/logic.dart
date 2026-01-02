import 'dart:io';

import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../model/ceobe/tool/tool.dart';
import '../../model/ceobe/video/video.dart';
import '../../request/bakery/bakery_request.dart';
import '../../request/ceobe/ceobe_request.dart';
import '../../request/manga/manga_request.dart';
import '../../route.dart';
import '../root/logic.dart';
import 'state.dart';

class MoreLogic extends GetxController {
  final MoreState state = MoreState();

  final _flowerDiary = ToolModel(
    nameSet: ToolNameSet('心花日记', '心花日记'),
    icon:
        'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/c5/3a/64/c53a6436-7752-7a4a-00b6-641a9978898a/AppIcon-0-0-1x_U007emarketing-0-8-0-85-220.png/400x400ia-75.webp',
    links: [
      ToolLink(
        primary: true,
        url:
            'store://appgallery.huawei.com/app/detail?id=top.idealclover.flowerdiary',
      )
    ],
  );

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
        // 只展示时间范围内的视频
        final now = DateTime.now();
        state.videoList.addAll((value.data ?? []).where((video) {
          final startTime = DateTime.tryParse(video.startTime);
          final overTime = DateTime.tryParse(video.overTime);
          return startTime != null &&
              overTime != null &&
              startTime.isBefore(now) &&
              overTime.isAfter(now);
        }));
      }
    });
    CeobeApi.getQuickJumpInfo().then((value) {
      if (!value.error) {
        state.quickJumpList.addAll(value.data ?? []);

        if (Platform.isOhos) {
          // 鸿蒙审核不允许应用内容存在点击跳转至第三方应用市场下载渠道
          // 以及引导用户下载安卓版/iOS版的模块或内容，因此隐藏小刻食堂、罗德岛助理
          state.quickJumpList.value = state.quickJumpList
              .where((e) => !const ['小刻食堂', '罗德岛助理'].contains(e.nameSet.zh))
              .toList();

          state.quickJumpList.insert(0, _flowerDiary);
        }
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
    DunJump.openAppOrWebPage(
      url: quickJump.url,
      appUrlScheme: quickJump.url.startsWith('http') ? '' : quickJump.url,
    );
  }

  void onTapVideoLink(VideoModel video) {
    var infoList = video.url.split("video/");
    if (infoList.length > 1) {
      String appUrl = "bilibili://video/${infoList[1]}";
      DunJump.openAppOrWebPage(url: video.url, appUrlScheme: appUrl);
    }
  }
}
