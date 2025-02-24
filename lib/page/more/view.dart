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
          padding: REdgeInsets.fromLTRB(12, 0, 12, 0),
          children: [
            _buildTitle(),
            SizedBox(height: 16.h),
            _buildOfficialManga(),
            SizedBox(height: 16.h),
            _buildHoneyCakeWorkshop(),
            SizedBox(height: 12.h),
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
    return ColoredBox(
      color: DunColors.gray_1,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: REdgeInsets.only(top: 11, left: 11, bottom: 10),
            child: Text(
              "常用工具&推荐",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.sp,
                color: DunColors.white,
              ),
            ),
          ),
          Positioned(
            right: -5.w,
            bottom: 7.h,
            child: Container(
              margin: REdgeInsets.only(bottom: 6),
              width: 17,
              height: 10,
              color: DunColors.yellow,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOfficialManga() {
    return GestureDetector(
      // 处理没有漫画的情况，不能跳转
      onTap: logic.onTapManga,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          color: DunColors.white,
          boxShadow: [DunTheme.cardShadow],
        ),
        child: Row(
          children: [
            _buildMangaTitle(),
            Expanded(
              child: Obx(() => Visibility(
                    replacement: const Center(child: Text("暂时还没有漫画更新")),
                    visible: state.terraRecentEpisode.value.updatedTime != 0,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 13.w),
                            _buildMangaImage(),
                            SizedBox(width: 12.w),
                            Padding(
                              padding: REdgeInsets.only(top: 14, bottom: 9),
                              child: DashedLineVerticalWidget(height: 117.h),
                            ),
                            SizedBox(width: 13.w),
                            Expanded(
                              child: _buildMangaInfo(),
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 12.h,
                          right: 0,
                          child: SizedBox(
                            width: 14.sp,
                            height: 14.sp,
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
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _buildMangaTitle() {
    String columnText = "官方漫画";
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(
        Text(
          columnText[i],
          style: TextStyle(color: DunColors.white, fontSize: 11.sp),
        ),
      );
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: REdgeInsets.only(left: 5, right: 4, top: 40, bottom: 40),
          color: DunColors.gray_1,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: titleTextList,
            ),
          ),
        ),
        Positioned(
          top: 6.h,
          right: -8.w,
          child: const SizedBox(
            width: 13,
            height: 8,
            child: ColoredBox(
              color: DunColors.blue,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMangaImage() {
    return Padding(
      padding: REdgeInsets.only(top: 14, bottom: 10),
      child: Obx(
        () => state.terraRecentEpisode.value.coverUrl != null
            ? ExtendedImage.network(
                state.terraRecentEpisode.value.coverUrl!,
                fit: BoxFit.cover,
                handleLoadingProgress: true,
                clearMemoryCacheIfFailed: true,
                clearMemoryCacheWhenDispose: false,
                mode: ExtendedImageMode.gesture,
                cache: true,
                height: 116.h,
                width: 179.w,
                loadStateChanged: (ExtendedImageState state) {
                  if (state.extendedImageLoadState != LoadState.completed) {
                    return Image(
                      height: 116.h,
                      width: 179.w,
                      fit: BoxFit.cover,
                      image: const AssetImage("assets/image/load/loading.gif"),
                    );
                  }
                  return null;
                },
              )
            : Image(
                height: 116.h,
                width: 179.w,
                fit: BoxFit.cover,
                image: const AssetImage("assets/image/load/loading.gif"),
              ),
      ),
    );
  }

  Widget _buildMangaInfo() {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildBlueSquare(),
              SizedBox(width: 6.w),
              Text(
                "最近更新",
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: REdgeInsets.only(left: 15),
            child: Text(
              "${state.terraRecentEpisode.value.title}:${state.terraRecentEpisode.value.episodeShortTitle}",
              style: TextStyle(fontSize: 12.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildBlueSquare(),
              SizedBox(width: 6.w),
              Text(
                "更新日期",
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: REdgeInsets.only(left: 15),
            child: Text(
              TimeUnit.timestampFormatYMD(
                  state.terraRecentEpisode.value.updatedTime),
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlueSquare() {
    return SizedBox(
      width: 9.sp,
      height: 9.sp,
      child: const ColoredBox(
        color: DunColors.blue,
      ),
    );
  }

  Widget _buildHoneyCakeWorkshop() {
    return GestureDetector(
      onTap: logic.onTapHoneyCakeWorkshop,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9)),
          color: DunColors.white,
          boxShadow: [DunTheme.cardShadow],
        ),
        child: Column(
          children: [
            _buildHoneyCakeWorkshopTitle(),
            SizedBox(height: 10.h),
            Obx(
              () => state.bakeryRecentPredict.value.id != ''
                  ? _buildHoneyCakeWorkshopContent()
                  : const Center(child: Text("饼学大厦还未有预测")),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHoneyCakeWorkshopTitle() {
    return ColoredBox(
      color: DunColors.gray_1,
      child: Row(
        children: [
          Padding(
            padding: REdgeInsets.only(left: 10, bottom: 3, top: 2),
            child: Text(
              "第三方工具 · 罗德岛密饼工坊",
              style: TextStyle(
                fontSize: 12.sp,
                color: DunColors.white,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: REdgeInsets.only(right: 8, bottom: 6, top: 7),
            child: SizedBox(
              width: 10.sp,
              height: 10.sp,
              child: const ColoredBox(color: DunColors.yellow),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHoneyCakeWorkshopContent() {
    return Row(
      children: [
        SizedBox(width: 13.w),
        ClipOval(
          child: Image.asset(
            "assets/image/bilibili_up_mbgf.webp",
            width: 41.sp,
          ),
        ),
        SizedBox(width: 9.w),
        Text(state.bakeryRecentPredict.value.daily.datetime,
            style: TextStyle(color: DunColors.gray_2, fontSize: 14.sp)),
        SizedBox(width: 11.w),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "饼学大厦：${state.bakeryRecentPredict.value.id}",
              style: TextStyle(color: DunColors.gray_2, fontSize: 14.sp),
            ),
            SizedBox(height: 5.h),
            DashedLineHorizontalWidget(width: 225.w),
            SizedBox(height: 5.h),
            Text(
              state.bakeryRecentPredict.value.daily.info.isNotEmpty
                  ? state.bakeryRecentPredict.value.daily.info[0].forecast
                  : "今日无预测内容",
              style: () {
                if (state.bakeryRecentPredict.value.daily.info.isNotEmpty &&
                    state.bakeryRecentPredict.value.daily.info[0]
                            .forecastStatus ==
                        "true") {
                  return TextStyle(color: DunColors.yellow, fontSize: 14.sp);
                } else if (state
                        .bakeryRecentPredict.value.daily.info.isNotEmpty &&
                    state.bakeryRecentPredict.value.daily.info[0]
                            .forecastStatus ==
                        "false") {
                  return TextStyle(
                      color: const Color(0xFF620703), fontSize: 14.sp);
                } else {
                  return TextStyle(color: DunColors.gray_2, fontSize: 14.sp);
                }
              }(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )),
        SizedBox(width: 17.w),
      ],
    );
  }

  Widget _buildToolLinks() {
    return Obx(() {
      if (state.quickJumpList.isEmpty) return const SizedBox.shrink();
      List<Widget> list = state.quickJumpList
          .map<Widget>((element) => ToolLinkCard(
                element,
                onTap: logic.onTapToolLink,
              ))
          .toList();
      if (list.length % 2 != 0) {
        list.add(const Spacer());
      }
      List<Row> rowList = [];
      for (var i = 0; i < list.length; i += 2) {
        var o1 = list[i];
        var o2 = list[i + 1];
        rowList.add(
          Row(
            children: [
              Flexible(child: o1),
              SizedBox(width: 8.w),
              Flexible(child: o2),
            ],
          ),
        );
      }
      return Padding(
        padding: REdgeInsets.only(bottom: 18.h),
        child: Column(
          children: List.generate(
            2 * rowList.length - 1,
            (index) =>
                index.isEven ? rowList[index ~/ 2] : SizedBox(height: 8.h),
          ),
        ),
      );
    });
  }

  Widget _buildVideoRecommend() {
    return Obx(() {
      if (state.videoList.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: REdgeInsets.only(bottom: 14.h),
        child: Column(
          children: [
            Container(
              color: DunColors.gray_1,
              child: Row(
                children: [
                  Padding(
                    padding: REdgeInsets.only(left: 10, bottom: 3, top: 2),
                    child: Text(
                      "视频推荐",
                      style: TextStyle(fontSize: 12.sp, color: DunColors.white),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: REdgeInsets.only(right: 8, bottom: 6, top: 7),
                    child: SizedBox(
                      width: 10.sp,
                      height: 10.sp,
                      child: const ColoredBox(color: DunColors.yellow),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 11.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.videoList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 9,
                crossAxisSpacing: 10,
                childAspectRatio: 171 / 160,
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
    });
  }
}
