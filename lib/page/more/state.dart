import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/bakery/bakery_data.dart';
import '../../model/ceobe/tool/tool.dart';
import '../../model/ceobe/video/video.dart';
import '../../model/manga/terra_recent_episode.dart';

class MoreState {
  RxList<VideoModel> videoList = RxList.empty();
  RxList<ToolModel> quickJumpList = RxList.empty();
  Rx<TerraRecentEpisodeModel> terraRecentEpisode =
      TerraRecentEpisodeModel.fromJson({}).obs;
  Rx<BakeryRecentPredictModel> bakeryRecentPredict =
      BakeryRecentPredictModel.fromJson({}).obs;
  final pageScrollController = ScrollController();

  MoreState() {
    ///Initialize variables
  }
}
