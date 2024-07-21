import 'dart:math' as math;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../common/time_unit.dart';
import '../../widget/dashed_line_widget.dart';
import '../../widget/more/tool_link.dart';
import '../../widget/more/video_link.dart';
import 'logic.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final logic = Get.put(MoreLogic());
  final state = Get.find<MoreLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreLogic>(
      builder: (logic) {
        return ListView(
          controller: state.pageScrollController,
          padding: REdgeInsets.fromLTRB(12, 0, 12, 12),
          children: [
            _buildTitle(),
            _buildOfficialManga(),
            _buildHoneyCakeWorkshop(),
            _buildToolLinks(),
            _buildVideoRecommend(),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30, bottom: 80),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: DunColors.gray_1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      height: 42,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: REdgeInsets.only(right: 7),
            padding: REdgeInsets.fromLTRB(12, 11, 0, 11),
            color: DunColors.gray_1,
            child: const Text(
              "常用工具&推荐",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: DunColors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: REdgeInsets.only(bottom: 6),
              width: 17,
              height: 10,
              color: DunColors.yellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficialManga() {
    String columnText = "官方漫画";
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(Text(columnText[i],
          style: const TextStyle(color: DunColors.white, fontSize: 11)));
    }
    return GestureDetector(
      // 处理没有漫画的情况，不能跳转
      onTap: logic.onTapManga,
      child: Container(
        margin: REdgeInsets.only(top: 14),
        height: 140,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          color: DunColors.white,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  color: DunColors.gray_1,
                  child: Center(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: titleTextList)),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: DunColors.white,
                    ),
                    child: state.terraRecentEpisode.updatedTime != 0
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 13),
                              // TODO: 这边一些参数意思不是很懂，要怎么搞
                              state.terraRecentEpisode.coverUrl != null
                                  ? ExtendedImage.network(
                                      state.terraRecentEpisode.coverUrl!,
                                      fit: BoxFit.cover,
                                      handleLoadingProgress: true,
                                      clearMemoryCacheIfFailed: true,
                                      clearMemoryCacheWhenDispose: false,
                                      mode: ExtendedImageMode.gesture,
                                      cache: true,
                                      height: 100,
                                      width: 180,
                                      loadStateChanged:
                                          (ExtendedImageState state) {
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
                                    )
                                  : const Image(
                                      height: 220,
                                      image: AssetImage(
                                          "assets/image/load/loading.gif")),
                              const SizedBox(width: 13),
                              const DashedLineVerticalWidget(height: 100),
                              const SizedBox(width: 13),
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
                                      margin: REdgeInsets.fromLTRB(11, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${state.terraRecentEpisode.title}:${state.terraRecentEpisode.episodeShortTitle}",
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
                                      margin: REdgeInsets.fromLTRB(11, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          TimeUnit.timestampFormatYMD(state
                                              .terraRecentEpisode.updatedTime),
                                          style: const TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : const Center(child: Text("暂时还没有漫画更新")),
                  ),
                ),
              ],
            ),
            Container(
              margin: REdgeInsets.fromLTRB(15, 6, 0, 0),
              width: 13,
              height: 8,
              color: DunColors.blue,
            ),
            state.terraRecentEpisode.updatedTime != 0
                ? Container(
                    alignment: Alignment.bottomRight,
                    padding: REdgeInsets.fromLTRB(0, 0, 12, 10),
                    child: SizedBox(
                        width: 16,
                        height: 16,
                        child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 5, color: DunColors.gray_1),
                                  right: BorderSide(
                                      width: 5, color: DunColors.gray_1)),
                            ),
                          ),
                        )),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _buildBlueSquare() {
    return Container(
      margin: REdgeInsets.fromLTRB(0, 0, 3, 0),
      width: 9,
      height: 9,
      color: DunColors.blue,
    );
  }

  Widget _buildHoneyCakeWorkshop() {
    return GestureDetector(
      onTap: logic.onTapHoneyCakeWorkshop,
      child: Container(
        margin: REdgeInsets.only(top: 14),
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9)),
          color: DunColors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 21,
              padding: REdgeInsets.fromLTRB(10, 2, 8, 2),
              color: DunColors.gray_1,
              child: Row(
                children: [
                  const Text(
                    "第三方工具 · 罗德岛密饼工坊",
                    style: TextStyle(
                      fontSize: 12,
                      color: DunColors.white,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: 10,
                    height: 10,
                    color: DunColors.yellow,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9)),
                  color: DunColors.white,
                ),
                child: state.bakeryRecentPredict.id != ''
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
                          Text(state.bakeryRecentPredict.daily.datetime,
                              style: const TextStyle(
                                  color: DunColors.gray_2, fontSize: 18)),
                          const SizedBox(
                            width: 11,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "饼学大厦：${state.bakeryRecentPredict.id}",
                                style: const TextStyle(
                                    color: DunColors.gray_2, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: REdgeInsets.fromLTRB(0, 0, 17, 0),
                                child: const DashedLineHorizontalWidget(
                                  width: 10000,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.bakeryRecentPredict.daily.info.isNotEmpty
                                    ? state.bakeryRecentPredict.daily.info[0]
                                        .forecast
                                    : "今日无预测内容",
                                style: (() {
                                  if (state.bakeryRecentPredict.daily.info
                                          .isNotEmpty &&
                                      state.bakeryRecentPredict.daily.info[0]
                                              .forecastStatus ==
                                          "true") {
                                    return const TextStyle(
                                        color: DunColors.yellow, fontSize: 14);
                                  } else if (state.bakeryRecentPredict.daily
                                          .info.isNotEmpty &&
                                      state.bakeryRecentPredict.daily.info[0]
                                              .forecastStatus ==
                                          "false") {
                                    return const TextStyle(
                                        color: Color(0xFF620703), fontSize: 14);
                                  } else {
                                    return const TextStyle(
                                        color: DunColors.gray_2, fontSize: 14);
                                  }
                                }()),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ))
                        ],
                      )
                    : const Center(child: Text("饼学大厦还未有预测")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolLinks() {
    if (state.quickJumpList.isEmpty) return const SizedBox();
    return Padding(
      padding: REdgeInsets.only(top: 14),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.quickJumpList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 3,
        ),
        itemBuilder: (ctx, index) {
          return Card(
              child: ToolLinkCard(
            state.quickJumpList[index],
            onTap: logic.onTapToolLink,
          ));
        },
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildVideoRecommend() {
    if (state.videoList.isEmpty) return const SizedBox();
    return Padding(
      padding: REdgeInsets.only(top: 14),
      child: Column(
        children: [
          Container(
            height: 21,
            padding: REdgeInsets.fromLTRB(10, 2, 8, 2),
            color: DunColors.gray_1,
            child: Row(
              children: [
                const Text(
                  "视频推荐",
                  style: TextStyle(
                    fontSize: 12,
                    color: DunColors.white,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  width: 10,
                  height: 10,
                  color: DunColors.yellow,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.videoList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              return VideoLinkCard(
                state.videoList[index],
                onTap: logic.onTapVideoLink,
              );
            },
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
