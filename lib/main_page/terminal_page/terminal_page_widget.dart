import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_circle_widget.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_line_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/ui/item_card_left_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/ui/set_up_button_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/ui/today_rotation.dart';
import 'package:dun_cookie_flutter/model/cookie_count_model.dart';
import 'package:dun_cookie_flutter/model/resource_info.dart';
import 'package:dun_cookie_flutter/request/cookie_request.dart';
import 'package:dun_cookie_flutter/request/tools_api.dart';
import 'package:dun_cookie_flutter/set_up/set_up_page.dart';
import 'package:flutter/material.dart';

import 'ui/prts_title_widget.dart';

class TerminalPageWidget extends StatefulWidget {
  const TerminalPageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TerminalPageWidgetState();
}

class _TerminalPageWidgetState extends State<TerminalPageWidget> {
  ResourceInfo? resourceInfo;
  CookieInfoCountModel? cookieInfoCount;

  @override
  void initState() {
    super.initState();
    ToolsApi.getResourceInfo()
        .then((value) => setState(() => resourceInfo = value));
    CookiesApi.getCookieCountList()
        .then((value) => setState(() => cookieInfoCount = value));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      _buildCakeWarehouse(cookieInfoCount),
      const SizedBox(height: 15),
      _buildResourceWidget(),
    ];
    for (var i = 0; i < (resourceInfo?.countdown?.length ?? 0); i++) {
      Countdown countdown = resourceInfo!.countdown![i];
      if (TimeUnit.isTimeRange(
          TimeUnit.utcChinaNow(), countdown.startTime, countdown.overTime)) {
        listWidget.add(const SizedBox(height: 15));
        listWidget.add(_buildActivityWidget(countdown, i));
      }
    }
    listWidget.add(const SizedBox(height: 40));
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 60),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 15),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: listWidget,
          )),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        const Expanded(child: PrtsTitleWidget()),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SetUpPage()),
          ),
          child: const SetUpButtonWidget(),
        ),
      ],
    );
  }

  Widget _buildCakeWarehouse(CookieInfoCountModel? cookieInfoCount) {
    return SizedBox(
      height: 240,
      child: Column(
        children: [
          Container(
            height: 23,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: gray_1,
            child: Row(
              children: [
                const Text(
                  "CAKE WAREHOUSE",
                  style: TextStyle(
                    fontSize: 11,
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
              decoration: BoxDecoration(
                color: white,
                border: Border.all(
                  color: yellow,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  /// 已发现的饼的数量
                  Positioned(
                    left: 10,
                    top: 9,
                    child: Container(width: 11, height: 22, color: yellow),
                  ),
                  const Positioned(
                    left: 24,
                    top: 7,
                    child: Column(
                      children: [
                        Text(
                          "已发现饼的数量",
                          style: TextStyle(
                            color: gray_1,
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
                                color: gray_1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const DashedLineHorizontalWidget(width: 50),
                            const SizedBox(width: 6),
                            Text(
                              cookieInfoCount?.skinCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
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
                                color: gray_1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const DashedLineHorizontalWidget(width: 50),
                            const SizedBox(width: 6),
                            Text(
                              cookieInfoCount?.operatorCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
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
                                color: gray_1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const DashedLineHorizontalWidget(width: 50),
                            const SizedBox(width: 6),
                            Text(
                              cookieInfoCount?.activityCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
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
                                color: gray_1,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const DashedLineHorizontalWidget(width: 59),
                            const SizedBox(width: 6),
                            Text(
                              cookieInfoCount?.epCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
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
                            borderColor: yellow,
                          ),
                          const Center(
                            child: Column(
                              children: [
                                SizedBox(height: 33),
                                Text(
                                  "HAVE FOUND",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: gray_1,
                                  ),
                                ),
                                SizedBox(height: 60),
                                DashedLineHorizontalWidget(width: 68),
                                Text(
                                  "CAKE",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: yellow,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              cookieInfoCount?.totalCount?.toString() ??
                                  "-----",
                              style: const TextStyle(
                                fontSize: 44,
                                color: gray_1,
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
    );
  }

  // 资源信息
  Widget _buildResourceWidget() {
    DateTime dt = TimeUnit.utcChinaNow();
    int weekDay = dt.weekday;
    return SizedBox(
      height: 97,
      child: Row(
        children: [
          ItemCardLeftWidget(
            columnText: "WEEK",
            titleText: "星期",
            centerText: TimeUnit.numberToWeek(weekDay),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 97,
              color: white,
              child: TodayResource(resourceInfo?.resources),
            ),
          ),
        ],
      ),
    );
  }

  // 活动信息
  Widget _buildActivityWidget(Countdown countdown, int index) {
    var timeDiff = TimeUnit.timeDiffUnit(countdown.time!);
    return SizedBox(
      height: 97,
      child: Row(
        children: [
          ItemCardLeftWidget(
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
                return red;
              } else {
                return blue;
              }
            }()),
            bottomText: timeDiff.unit,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              color: white,
              padding: const EdgeInsets.all(6),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(countdown.text ?? ""),
                    Text(countdown.remark ?? ""),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
