import 'dart:math' as math;

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';

// import 'package:dun_cookie_flutter/honey_cake_workshop/honey_cake_workshop_page.dart';
import 'package:dun_cookie_flutter/page/manga/manga_list.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/video_model.dart';
import 'package:dun_cookie_flutter/page/main/more/ui/tool_link.dart';
import 'package:dun_cookie_flutter/page/main/more/ui/tool_video.dart';
import 'package:dun_cookie_flutter/request/cookie_request.dart';
import 'package:dun_cookie_flutter/request/tools_api.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../model/bakery_data.dart';
import '../../../model/terra_recent_episode_model.dart';
import '../../../request/bakery_request.dart';
import '../../honey_cake_workshop/honey_cake_workshop_page.dart';
import '../ui/common/dashed_line_widget.dart';

class MoreListWidget extends StatefulWidget {
  @override
  State<MoreListWidget> createState() => _MoreListWidgetState();
}

class _MoreListWidgetState extends State<MoreListWidget>
    with AutomaticKeepAliveClientMixin {
  CeobecanteenData? ceobecanteenData;
  List<VideoModel> videoList = [];
  List<QuickJump> quickJumpList = [];
  TerraRecentEpisodeModel? terraRecentEpisode;
  BakeryRecentPredictModel? bakeryRecentPredict;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    ToolsApi.getVideoList().then((value) => setState(() => videoList = value));
    ToolsApi.getToolLinkInfoUrl()
        .then((value) => setState(() => quickJumpList = value));
    CookiesApi.getTerraNewestEpisode()
        .then((value) => setState(() => terraRecentEpisode = value));
    BakeryRequest.getBakeryRecentPredict()
        .then((value) => setState(() => bakeryRecentPredict = value));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                color: yellow,
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
      titleTextList.add(Text(columnText[i],
          style: const TextStyle(color: white, fontSize: 11)));
    }
    return GestureDetector(
      // 处理没有漫画的情况，不能跳转
      onTap: terraRecentEpisode != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MangaListPage()),
              )
          : () => {},
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        height: 140,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          color: white,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 20.w,
                  color: gray_1,
                  child: Center(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: titleTextList)),
                ),
                Expanded(
                  child: Container(
                    child: terraRecentEpisode != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 13.w),
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
                                width: 180.w,
                                loadStateChanged: (ExtendedImageState state) {
                                  if (state.extendedImageLoadState ==
                                      LoadState.loading) {
                                    return const Center(
                                        child: Image(
                                            height: 220,
                                            image: AssetImage(
                                                "assets/image/load/loading.gif")));
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(width: 13.w),
                              const DashedLineVerticalWidget(height: 100),
                              SizedBox(width: 13.w),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 26),
                                    Row(children: [
                                      _buildBlueSquare(),
                                      const Text("最近更新",
                                          style: TextStyle(fontSize: 12)),
                                    ]),
                                    const SizedBox(height: 8),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          11, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        terraRecentEpisode!.title! +
                                            ":" +
                                            terraRecentEpisode!
                                                .episodeShortTitle!,
                                        style: const TextStyle(fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(children: [
                                      _buildBlueSquare(),
                                      const Text("更新日期",
                                          style: TextStyle(fontSize: 12)),
                                    ]),
                                    const SizedBox(height: 8),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          11, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          TimeUnit.timestampFormatYMD(
                                              terraRecentEpisode!.updatedTime!),
                                          style: const TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : const Center(child: Text("暂时还没有漫画更新")),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
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
            terraRecentEpisode != null
                ? Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 10),
                    child: SizedBox(
                        width: 16,
                        height: 16,
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 5, color: gray_1),
                                  right: BorderSide(width: 5, color: gray_1)),
                            ),
                          ),
                        )),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildBlueSquare() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
      width: 9,
      height: 9,
      color: blue,
    );
  }

  Widget _buildHoneyCakeWorkshop() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HoneyCakeWorkshopPage()),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9)),
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
                child: bakeryRecentPredict != null
                    ? Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          ClipOval(
                              child: Image.asset(
                            "assets/image/bilibili_up_mbgf.webp",
                            width: 40,
                          )),
                          const SizedBox(
                            width: 18,
                          ),
                          Text(bakeryRecentPredict!.daily!.datetime!,
                              style:
                                  const TextStyle(color: gray_2, fontSize: 18)),
                          const SizedBox(
                            width: 11,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "饼学大厦：${bakeryRecentPredict!.id!}",
                                style: const TextStyle(
                                    color: gray_2, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 17, 0),
                                child: const DashedLineHorizontalWidget(
                                  width: 10000,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                bakeryRecentPredict?.daily?.info != null &&
                                        bakeryRecentPredict!
                                            .daily!.info!.isNotEmpty
                                    ? bakeryRecentPredict!
                                        .daily!.info![0].forecast!
                                    : "今日无预测内容",
                                style: (() {
                                  if (bakeryRecentPredict?.daily?.info !=
                                          null &&
                                      bakeryRecentPredict!
                                          .daily!.info!.isNotEmpty &&
                                      bakeryRecentPredict?.daily?.info?[0]
                                              .forecastStatus ==
                                          "true") {
                                    return const TextStyle(
                                        color: yellow, fontSize: 14);
                                  } else if (bakeryRecentPredict?.daily?.info !=
                                          null &&
                                      bakeryRecentPredict!
                                          .daily!.info!.isNotEmpty &&
                                      bakeryRecentPredict?.daily?.info?[0]
                                              .forecastStatus ==
                                          "false") {
                                    return const TextStyle(
                                        color: Color(0xFF620703), fontSize: 14);
                                  } else {
                                    return const TextStyle(
                                        color: gray_2, fontSize: 14);
                                  }
                                }()),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ))
                        ],
                      )
                    : const Center(child: Text("饼学大厦还未有预测")),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9)),
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolLinks() {
    if (quickJumpList.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: quickJumpList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 3,
        ),
        itemBuilder: (ctx, index) {
          return Card(child: ToolLink(quickJumpList[index]));
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
