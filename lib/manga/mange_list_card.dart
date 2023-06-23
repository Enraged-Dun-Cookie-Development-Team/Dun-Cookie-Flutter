import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_tag.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/model/Terra_comic_episode_model.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/model/terra_comic_model.dart';
import 'package:dun_cookie_flutter/request/cookie_request.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MangaListCard extends StatefulWidget {
  const MangaListCard(this.comicModel, {Key? key}) : super(key: key);

  final TerraComicModel comicModel;

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
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          if(!_isExpanded && episodes.isEmpty) {
            episodes = await CookiesApi.getTerraComicEpisodeList(widget.comicModel.comic!);
          }
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          children: [
            ExtendedImage.network(
              widget.comicModel.cover!,
              fit: BoxFit.cover,
              handleLoadingProgress: true,
              clearMemoryCacheIfFailed: true,
              clearMemoryCacheWhenDispose: false,
              mode: ExtendedImageMode.gesture,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                if (state.extendedImageLoadState == LoadState.loading) {
                  return const Center(
                      child:
                          Image(height: 220, image: AssetImage("assets/image/load/loading.gif")));
                }
                return null;
              },
            ),
            ExpansionPanelList(
              elevation: 0,
              expansionCallback: (panelIndex, isExpanded) async {
                if(!isExpanded && episodes.isEmpty) {
                  episodes = await CookiesApi.getTerraComicEpisodeList(widget.comicModel.comic!);
                }
                setState(() {
                  _isExpanded = !isExpanded;
                });
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 10),
                      child: Text("共${widget.comicModel.count}章，最新于${TimeUnit.timestampFormatYMD(widget.comicModel.updateTime!)}更新"),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                              widget.comicModel.keywords?.length ?? 0, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: DunTag(widget.comicModel.keywords![index]),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.comicModel.title ?? "",
                          style: DunStyles.text16,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        widget.comicModel.subtitle == "" ? Container() : Text(
                          widget.comicModel.subtitle ?? "",
                          style: DunStyles.text16B,
                        ),
                        widget.comicModel.subtitle == "" ? Container() : const SizedBox(
                          height: 6,
                        ),
                        Text(widget.comicModel.introduction ?? "",
                            style: DunStyles.text14B),
                        const SizedBox(
                          height: 6,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(episodes.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                OpenAppOrBrowser.openUrl(
                                    episodes[index].jumpUrl ?? "",
                                    context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                margin: const EdgeInsets.only(bottom: 10, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: DunColors.DunColor),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                    episodes[index].shortTitle ?? "",
                                )
                              ),
                            );
                          }),
                        )
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
