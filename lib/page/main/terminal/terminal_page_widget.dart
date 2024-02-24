import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/page/main/ui/common/dashed_circle_widget.dart';

import 'package:dun_cookie_flutter/page/main/ui/terminal/item_card_left_widget.dart';
import 'package:dun_cookie_flutter/page/main/ui/terminal/set_up_button_widget.dart';
import 'package:dun_cookie_flutter/page/main/ui/terminal/today_rotation.dart';
import 'package:dun_cookie_flutter/model/cookie_count_model.dart';
import 'package:dun_cookie_flutter/model/resource_info.dart';
import 'package:dun_cookie_flutter/request/cookie_request.dart';
import 'package:dun_cookie_flutter/request/tools_api.dart';
import 'package:dun_cookie_flutter/page/setting/set_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ui/common/dashed_line_widget.dart';
import '../ui/terminal/prts_title_widget.dart';

class TerminalPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminalPageWidgetState();
}

class _TerminalPageWidgetState extends State<TerminalPageWidget>
    with AutomaticKeepAliveClientMixin {
  ResourceInfo? resourceInfo;
  CookieInfoCountModel? cookieInfoCount;

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    List<Widget> listWidget = [
      _buildCakeWarehouse(cookieInfoCount),
      SizedBox(height: 15.h),
      _buildResourceWidget(),
    ];
    for (var i = 0; i < (resourceInfo?.countdown?.length ?? 0); i++) {
      Countdown countdown = resourceInfo!.countdown![i];
      if (TimeUnit.isTimeRange(
          TimeUnit.utcChinaNow(), countdown.startTime, countdown.overTime)) {
        listWidget.add(SizedBox(height: 15.h));
        listWidget.add(_buildActivityWidget(countdown, i));
      }
    }
    listWidget.add(SizedBox(height: 40.h));
    return Padding(
      padding: REdgeInsets.fromLTRB(12, 12, 12, 60),
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(height: 15.h),
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
        SizedBox(width: 8.w),
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
      height: 240.h,
      child: Column(
        children: [
          Container(
            height: 23.h,
            padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                  width: 10.w,
                  height: 10.h,
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
                  width: 1.w,
                ),
              ),
              child: Stack(
                children: [
                  /// 已发现的饼的数量
                  Positioned(
                    left: 10.w,
                    top: 9.h,
                    child: Container(width: 11.w, height: 22.h, color: yellow),
                  ),
                  Positioned(
                    left: 24.w,
                    top: 7.h,
                    child: Column(
                      children: [
                        const Text(
                          "已发现饼的数量",
                          style: TextStyle(
                            color: gray_1,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        DashedLineHorizontalWidget(width: 112.w),
                      ],
                    ),
                  ),

                  /// itemList
                  Positioned(
                    left: 17.w,
                    top: 42.h,
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
                            SizedBox(width: 6.w),
                            DashedLineHorizontalWidget(width: 50.w),
                            SizedBox(width: 6.w),
                            Text(
                              cookieInfoCount?.skinCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            const Text(
                              "角色",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            DashedLineHorizontalWidget(width: 50.w),
                            SizedBox(width: 6.w),
                            Text(
                              cookieInfoCount?.operatorCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            const Text(
                              "活动",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            DashedLineHorizontalWidget(width: 50.w),
                            SizedBox(width: 6.w),
                            Text(
                              cookieInfoCount?.activityCount?.toString() ?? "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            const Text(
                              "EP",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            DashedLineHorizontalWidget(width: 59.w),
                            SizedBox(width: 6.w),
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
                    right: 24.w,
                    top: 20.h,
                    child: SizedBox(
                      width: 154.w,
                      height: 154.h,
                      child: Stack(
                        children: [
                          DashedCircleBorder(
                            borderWidth: 154.w,
                            borderColor: yellow,
                          ),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 33.h),
                                const Text(
                                  "HAVE FOUND",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: gray_1,
                                  ),
                                ),
                                SizedBox(height: 60.h),
                                DashedLineHorizontalWidget(width: 68.w),
                                const Text(
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
      height: 97.h,
      child: Row(
        children: [
          ItemCardLeftWidget(
            columnText: "WEEK",
            titleText: "星期",
            centerText: TimeUnit.numberToWeek(weekDay),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Container(
              height: 97.h,
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
      height: 97.h,
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
          SizedBox(width: 6.w),
          Expanded(
            child: Container(
              color: white,
              padding: REdgeInsets.all(6),
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
