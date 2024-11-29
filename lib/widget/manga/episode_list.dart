import 'package:dun_cookie_flutter/common/dun_tool.dart';
import 'package:dun_cookie_flutter/model/manga/terra_comic_episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/dun_color.dart';

class EpisodeList extends StatelessWidget {
  final List<TerraComicEpisodeModel> episodes;
  final String? lastView;
  final Function(TerraComicEpisodeModel url)? onTapEpisode;

  const EpisodeList(
      {super.key, required this.episodes, this.onTapEpisode, this.lastView});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: List.generate(episodes.length, (index) {
        return GestureDetector(
          onTap: () => onTapEpisode?.call(episodes[index]),
          child: _episodeItem(episodes[index]),
        );
      }),
    );
  }

  _episodeItem(TerraComicEpisodeModel model) {
    String episodeId = model.episodeId;
    if (episodeId.isEmpty) {
      episodeId = MangaTool.getEpisodeId(model.jumpUrl);
    }
    return GestureDetector(
      onTap: () => onTapEpisode?.call(model),
      child: Container(
          padding: REdgeInsets.symmetric(vertical: 2, horizontal: 8),
          margin: REdgeInsets.only(bottom: 10, right: 10),
          decoration: BoxDecoration(
              color: episodeId == lastView ? DunColors.DunColor : null,
              border: Border.all(color: DunColors.DunColor),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            model.shortTitle,
            style: TextStyle(
              color: episodeId == lastView ? Colors.white : null,
            ),
          )),
    );
  }
}
