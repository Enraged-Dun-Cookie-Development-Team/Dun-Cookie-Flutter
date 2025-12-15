import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../common/time_unit.dart';
import '../../manager/setting_manager.dart';
import '../../model/manga/terra_comic.dart';
import '../../model/manga/terra_comic_episode.dart';
import '../../request/manga/manga_request.dart';
import '../dun_tag.dart';
import '../image/dun_image.dart';
import 'episode_list.dart';

class MangaListCard extends StatefulWidget {
  const MangaListCard({
    super.key,
    required this.comicModel,
    required this.onTapEpisode,
  });

  final TerraComicModel comicModel;
  final Function(TerraComicEpisodeModel url) onTapEpisode;

  @override
  State<MangaListCard> createState() => _MangaListCardState();
}

class _MangaListCardState extends State<MangaListCard> {
  bool _isExpanded = false;
  List<TerraComicEpisodeModel> episodes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: REdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          if (!_isExpanded && episodes.isEmpty) {
            var responseData = await MangaApi.getTerraComicEpisodeList(
                widget.comicModel.comic);
            if (!responseData.error) {
              episodes = responseData.data ?? [];
            }
          }
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          children: [
            DunImage.network(
              widget.comicModel.cover,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            ExpansionPanelList(
              elevation: 0,
              expansionCallback: (panelIndex, isExpanded) async {
                if (!_isExpanded && episodes.isEmpty) {
                  var responseData = await MangaApi.getTerraComicEpisodeList(
                      widget.comicModel.comic);
                  if (!responseData.error) {
                    episodes = responseData.data ?? [];
                  }
                }
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  backgroundColor: Colors.transparent,
                  headerBuilder: (context, isExpanded) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: REdgeInsets.only(left: 10),
                      child: Text(
                          "共${widget.comicModel.count}章，最新于${TimeUnit.timestampFormatYMD(widget.comicModel.updateTime)}更新"),
                    );
                  },
                  body: Padding(
                    padding: REdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: List.generate(
                              widget.comicModel.keywords.length, (index) {
                            return Container(
                              margin: REdgeInsets.only(right: 5),
                              child: DunTag(widget.comicModel.keywords[index]),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.comicModel.title,
                          style: DunStyles.text16,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        widget.comicModel.subtitle == ""
                            ? Container()
                            : Text(
                                widget.comicModel.subtitle,
                                style: DunStyles.text16B45,
                              ),
                        widget.comicModel.subtitle == ""
                            ? Container()
                            : const SizedBox(
                                height: 6,
                              ),
                        Text(widget.comicModel.introduction,
                            style: DunStyles.text14B45),
                        const SizedBox(
                          height: 6,
                        ),
                        Obx(
                          () => EpisodeList(
                            episodes: episodes,
                            lastView: SettingManager.getInstance()
                                .mangaHistory[widget.comicModel.comic],
                            onTapEpisode: widget.onTapEpisode,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isExpanded: _isExpanded,
                ),
              ],
              animationDuration: kThemeAnimationDuration,
            ),
          ],
        ),
      ),
    );
  }
}
