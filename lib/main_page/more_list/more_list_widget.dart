import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_line_widget.dart';
// import 'package:dun_cookie_flutter/honey_cake_workshop/honey_cake_workshop_page.dart';
import 'package:dun_cookie_flutter/manga/manga_list.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/video_model.dart';
import 'package:dun_cookie_flutter/page/tool/tool_link.dart';
import 'package:dun_cookie_flutter/page/tool/tool_video.dart';
import 'package:dun_cookie_flutter/request/cookie_request.dart';
import 'package:dun_cookie_flutter/request/tools_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../common/tool/string_slice.dart';
import '../../model/bakery_data.dart';
import '../../model/terra_recent_episode_model.dart';
import '../../request/bakery_request.dart';

class MoreListWidget extends StatefulWidget {
  const MoreListWidget({Key? key}) : super(key: key);

  @override
  State<MoreListWidget> createState() => _MoreListWidgetState();
}

class _MoreListWidgetState extends State<MoreListWidget> {
  CeobecanteenData? ceobecanteenData;
  List<VideoModel> videoList = [];
  TerraRecentEpisodeModel? terraRecentEpisode;
  BakeryRecentPredictModel? bakeryRecentPredict;

  @override
  void initState() {
    super.initState();
    ToolsApi.getVideoList().then((value) => setState(() => videoList = value));
    CookiesApi.getTerraNewestEpisode().then((value) => setState(() =>terraRecentEpisode = value));
    BakeryRequest.getBakeryRecentPredict().then((value) => setState(() => bakeryRecentPredict = value));
  }

  @override
  Widget build(BuildContext context) {
    ceobecanteenData = Provider.of<CeobecanteenData>(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 150),
      children: [
        _buildTitle(),
        _buildOfficialManga(),
        _buildHoneyCakeWorkshop(),
        _buildToolLinks(),
        _buildVideoRecommend(),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "没有更多了",
              style: TextStyle(color: gray_1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14 - 7, 0),
      child: SizedBox(
        height: 42,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 7),
              padding: const EdgeInsets.fromLTRB(12, 11, 0, 11),
              color: gray_1,
              child: const Text(
                "常用工具&推荐",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                width: 17,
                height: 10,
                color: gray_2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficialManga() {
    String columnText = "官方漫画";
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(Text(columnText[i], style: const TextStyle(color: white, fontSize: 11)));
    }
    return GestureDetector(
      // 处理没有漫画的情况，不能跳转
      onTap: terraRecentEpisode != null ? () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MangaListPage()),
      ) : () => {},
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        height: 140,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5)
          ),
          color: white,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  color: gray_1,
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: titleTextList)),
                ),
                Expanded(
                  child: Container(
                    child: terraRecentEpisode != null ? Row(
                      children: [
                        const SizedBox(
                          width: 13,
                        ),
                        // TODO: 这边一些参数意思不是很懂，要怎么搞
                        ExtendedImage.network(
                          terraRecentEpisode!.coverUrl!,
                          fit: BoxFit.cover,
                          handleLoadingProgress: true,
                          clearMemoryCacheIfFailed: true,
                          clearMemoryCacheWhenDispose: false,
                          mode: ExtendedImageMode.gesture,
                          cache: true,
                          height: 100,
                          width: 180,
                          loadStateChanged: (ExtendedImageState state) {
                            if (state.extendedImageLoadState == LoadState.loading) {
                              return const Center(
                                  child:
                                  Image(height: 220, image: AssetImage("assets/image/load/loading.gif")));
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        // TODO: 这个居中方法不太好
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: const DashedLineVerticalWidget(height: 150),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        // TODO: 这边如果不用expanded的话, 没办法统一从左开始，不知道为什么
                        Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 26,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                    width: 9,
                                    height: 9,
                                    color: blue,
                                  ),
                                  const Text(
                                      "最近更新",
                                      style: TextStyle(fontSize: 12)
                                  ),
                                ]
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  StringSliceUtil.stringSliceAndMore(terraRecentEpisode!.title!+":"+terraRecentEpisode!.episodeShortTitle!, 7),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                      width: 9,
                                      height: 9,
                                      color: blue,
                                    ),
                                    const Text(
                                        "更新日期",
                                        style: TextStyle(fontSize: 12)
                                    ),
                                  ]
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    TimeUnit.timestampFormatYMD(terraRecentEpisode!.updatedTime!),
                                    style: const TextStyle(fontSize: 12)
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ) : const Center(child:Text("暂时还没有漫画更新")),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)
                      ),
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 6, 0, 0),
              width: 13,
              height: 8,
              color: blue,
            ),
            terraRecentEpisode != null ? Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 10),
              child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(width: 5, color: gray_1), right: BorderSide(width: 5, color: gray_1)),
                      ),
                    ),
                  )
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildHoneyCakeWorkshop() {
    return GestureDetector(
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HoneyCakeWorkshopPage()),
      // ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: white,
        ),
        child: Column(
          children: [
            Container(
              height: 21,
              padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
              color: gray_1,
              child: Row(
                children: [
                  const Text(
                    "第三方工具 · 罗德岛密饼工坊",
                    style: TextStyle(
                      fontSize: 12,
                      color: white,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: 10,
                    height: 10,
                    color: yellow,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: white,
                child: const Center(
                  child: Text("罗德岛蜜饼工坊"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolLinks() {
    List<QuickJump>? dataList = ceobecanteenData?.quickJump;
    if (dataList == null || dataList.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 3,
        ),
        itemBuilder: (ctx, index) {
          return Card(child: ToolLink(dataList[index]));
        },
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildVideoRecommend() {
    if (videoList.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Column(
        children: [
          Container(
            height: 21,
            padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
            color: gray_1,
            child: Row(
              children: [
                const Text(
                  "视频推荐",
                  style: TextStyle(
                    fontSize: 12,
                    color: white,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  width: 10,
                  height: 10,
                  color: yellow,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: videoList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (ctx, index) {
              return Card(child: ToolVideo(videoList[index]));
            },
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
