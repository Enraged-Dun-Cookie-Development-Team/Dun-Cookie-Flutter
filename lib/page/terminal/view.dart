
import 'package:dun_cookie_flutter/common/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../common/time_unit.dart';
import '../../model/ceobe/resource/resource_info.dart';
import '../../model/cookie/cookie_count.dart';
import '../../widget/dashed_circle_widget.dart';
import '../../widget/dashed_line_widget.dart';
import '../../widget/terminal/item_card.dart';
import '../../widget/terminal/item_leading_widget.dart';
import '../../widget/terminal/today_rotation.dart';
import 'logic.dart';

class TerminalPage extends StatefulWidget {
  const TerminalPage({super.key});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  final logic = Get.put(TerminalLogic());
  final state = Get.find<TerminalLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TerminalLogic>(
      id: state.rootGID,
      builder: (logic) {
        return ListView(
          controller: state.pageScrollController,
          padding: REdgeInsets.fromLTRB(12, 0, 12, 12),
          children: [
            _buildTitleBar(),
            _buildCakeWarehouse(state.cookieInfoCount),
            _buildResourceWidget(state.resourceInfo.resources),
            _buildActivityWidget(state.resourceInfo.countdown),
            const SizedBox(
              height: 60,
            )
          ],
        );
      },
    );
  }

  _buildTitleBar() {
    return SizedBox(
      height: 42,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SizedBox(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: double.infinity,
                    padding: REdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 25),
                    color: DunColors.gray_1,
                    child: const Row(
                      children: [
                        Text(
                          "P R T S",
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          "欢迎回来，博士！",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -10,
                    bottom: 10,
                    child: Container(
                      width: 17.w,
                      height: 10,
                      color: DunColors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Container(
            width: 14.w,
            color: DunColors.gray_1,
          ),
          GestureDetector(
            onTap: logic.onTapSetting,
            child: Container(
                color: Colors.white,
                child: Container(
                  padding: REdgeInsets.all(5),
                  child: Assets.icon.settings.image(),
                )),
          ),
          Container(
            width: 14.w,
            color: DunColors.gray_1,
          ),
        ],
      ),
    );
  }

  _buildCakeWarehouse(CookieInfoCountModel cookieInfoCount) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: 240,
        child: Column(
          children: [
            Container(
              height: 23,
              padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: DunColors.gray_1,
              child: Row(
                children: [
                  const Text(
                    "CAKE WAREHOUSE",
                    style: TextStyle(
                      fontSize: 11,
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
                decoration: BoxDecoration(
                  color: DunColors.white,
                  border: Border.all(
                    color: DunColors.yellow,
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    /// 已发现的饼的数量
                    Positioned(
                      left: 10,
                      top: 9,
                      child: Container(width: 11, height: 22, color: DunColors.yellow),
                    ),
                    const Positioned(
                      left: 24,
                      top: 7,
                      child: Column(
                        children: [
                          Text(
                            "已发现饼的数量",
                            style: TextStyle(
                              color: DunColors.gray_1,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 3),
                          DashedLineHorizontalWidget(width: 112),
                        ],
                      ),
                    ),

                    /// itemList
                    Positioned(
                      left: 17,
                      top: 42,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "皮肤",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const DashedLineHorizontalWidget(width: 50),
                              const SizedBox(width: 6),
                              Text(
                                cookieInfoCount.skinCount.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text(
                                "角色",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const DashedLineHorizontalWidget(width: 50),
                              const SizedBox(width: 6),
                              Text(
                                cookieInfoCount.operatorCount.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text(
                                "活动",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const DashedLineHorizontalWidget(width: 50),
                              const SizedBox(width: 6),
                              Text(
                                cookieInfoCount.activityCount.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text(
                                "EP",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const DashedLineHorizontalWidget(width: 59),
                              const SizedBox(width: 6),
                              Text(
                                cookieInfoCount.epCount.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: DunColors.gray_1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// 右侧圆圈以及饼的总数
                    Positioned(
                      right: 24,
                      top: 20,
                      child: SizedBox(
                        width: 154,
                        height: 154,
                        child: Stack(
                          children: [
                            const DashedCircleBorder(
                              borderWidth: 154,
                              borderColor: DunColors.yellow,
                            ),
                            const Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 33),
                                  Text(
                                    "HAVE FOUND",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: DunColors.gray_1,
                                    ),
                                  ),
                                  SizedBox(height: 60),
                                  DashedLineHorizontalWidget(width: 68),
                                  Text(
                                    "CAKE",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: DunColors.yellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                cookieInfoCount.totalCount == 0
                                    ? "-----"
                                    : cookieInfoCount.totalCount.toString(),
                                style: const TextStyle(
                                  fontSize: 44,
                                  color: DunColors.gray_1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 资源信息
  _buildResourceWidget(Resources resources) {
    DateTime dt = TimeUnit.utcChinaNow();
    int weekDay = dt.weekday;
    return Padding(
      padding: REdgeInsets.only(bottom: 15),
      child: ItemCard(
          leading: ItemLeadingWidget(
            columnText: "WEEK",
            titleText: "星期",
            centerText: TimeUnit.numberToWeek(weekDay),
          ),
          content: TodayResource(resources)),
    );
  }

  // 活动信息
  _buildActivityWidget(List<Countdown> countdowns) {
    List<Widget> activityWidgetList = [];
    for (int index = 0; index < countdowns.length; index++) {
      Countdown countdown = countdowns[index];
      var timeDiff = TimeUnit.timeDiffUnit(countdown.time);
      if ((TimeUnit.isTimeRange(
          TimeUnit.utcChinaNow(), countdown.startTime, countdown.overTime))) {
        activityWidgetList.add(
          Padding(
            padding: REdgeInsets.only(bottom: 15),
            child: ItemCard(
              height: countdown.countdownType == "activity" ? 120 : 97,
              leading: ItemLeadingWidget(
                columnText: (() {
                  if (countdown.countdownType == "banner") {
                    return "BANNER";
                  } else if (countdown.countdownType == "activity") {
                    return "ACTIVITY";
                  } else if (countdown.countdownType == "live") {
                    return "LIVE";
                  } else {
                    return "EVENT";
                  }
                }()),
                titleText: (() {
                  if (countdown.countdownType == "banner") {
                    return "卡池剩余";
                  } else if (countdown.countdownType == "activity") {
                    return "活动剩余";
                  } else if (countdown.countdownType == "live") {
                    return "直播剩余";
                  } else {
                    return "剩余";
                  }
                }()),
                centerText: timeDiff.number.toString(),
                labelColor: (() {
                  if (index % 2 == 0) {
                    return DunColors.red;
                  } else {
                    return DunColors.blue;
                  }
                }()),
                bottomText: timeDiff.unit,
              ),
              content: Container(
                color: DunColors.white,
                padding: REdgeInsets.all(6),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(countdown.text),
                      Text(countdown.remark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return Column(
      children: activityWidgetList,
    );
  }
}
