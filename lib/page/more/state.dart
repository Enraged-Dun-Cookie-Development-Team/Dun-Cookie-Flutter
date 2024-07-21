import 'package:flutter/material.dart';

import '../../model/bakery/bakery_data.dart';
import '../../model/ceobe/tool/tool.dart';
import '../../model/ceobe/video/video.dart';
import '../../model/manga/terra_recent_episode.dart';

class MoreState {
  List<VideoModel> videoList = [];
  List<ToolModel> quickJumpList = [];
  TerraRecentEpisodeModel terraRecentEpisode =
      TerraRecentEpisodeModel.fromJson({});
  BakeryRecentPredictModel bakeryRecentPredict =
      BakeryRecentPredictModel.fromJson({});
  final pageScrollController = ScrollController();

  MoreState() {
    ///Initialize variables
  }
}
