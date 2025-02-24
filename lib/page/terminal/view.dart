import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../common/time_unit.dart';
import '../../model/ceobe/resource/resource_info.dart';
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
          padding: REdgeInsets.fromLTRB(10, 0, 9, 12),
          children: [
            _buildTitleBar(),
            SizedBox(height: 15.h),
            _buildCakeWarehouse(),
            SizedBox(height: 15.h),
            Obx(() => _buildResourceWidget(state.resourceInfo.value.resources)),
            Obx(() => _buildActivityWidget(state.resourceInfo.value.countdown)),
            SizedBox(height: 60.h)
          ],
        );
      },
    );
  }

  _buildTitleBar() {
    return SizedBox(
      height: 42.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: REdgeInsets.only(
                      top: 10, bottom: 11, left: 15, right: 23),
                  color: DunColors.gray_1,
                  child: Row(
                    children: [
                      Text(
                        "P R T S",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      const Spacer(),
                      Text(
                        "欢迎回来，博士！",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -7.w,
                  bottom: 6.h,
                  child: SizedBox(
                    width: 17.w,
                    height: 10.h,
                    child: const ColoredBox(color: DunColors.yellow),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          SizedBox(
            width: 14.w,
            child: const ColoredBox(
              color: DunColors.gray_1,
            ),
          ),
          GestureDetector(
            onTap: logic.onTapSetting,
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: REdgeInsets.all(5),
                child: Image.asset(
                  "assets/icon/settings.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 14.w,
            child: const ColoredBox(
              color: DunColors.gray_1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCakeWarehouse() {
    return Column(
      children: [
        _cakeWarehouseTitle(),
        _cakeWarehouseContent(),
      ],
    );
  }

  Widget _cakeWarehouseTitle() {
    return ColoredBox(
      color: DunColors.gray_1,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.sp),
            child: Text(
              "CAKE WAREHOUSE",
              style: TextStyle(
                fontSize: 11.sp,
                color: DunColors.white,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 10.sp,
            height: 10.sp,
            child: const ColoredBox(
              color: DunColors.yellow,
            ),
          ),
          SizedBox(width: 7.w),
        ],
      ),
    );
  }

  Widget _cakeWarehouseContent() {
    return Container(
      decoration: const BoxDecoration(
        color: DunColors.white,
        border: Border(
          left: BorderSide(color: DunColors.yellow, width: 1),
          right: BorderSide(color: DunColors.yellow, width: 1),
          bottom: BorderSide(color: DunColors.yellow, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10.w),
          _cookieCountInfo(),
          const Spacer(),
          Padding(
            padding: REdgeInsets.only(top: 20, bottom: 43),
            child: _cakeInfoRing(),
          ),
          SizedBox(width: 24.w),
        ],
      ),
    );
  }

  Widget _cookieCountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 7.h),
        Row(
          children: [
            Padding(
              padding: REdgeInsets.only(top: 2),
              child: SizedBox(
                width: 11.w,
                height: 22.h,
                child: const ColoredBox(
                  color: DunColors.yellow,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "已发现饼的数量",
                  style: TextStyle(
                    color: DunColors.gray_1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: REdgeInsets.only(left: 2),
                  child: DashedLineHorizontalWidget(width: 112.w),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 11.h),
        SizedBox(
          width: 140.w,
          child: Padding(
            padding: REdgeInsets.only(left: 7, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cookieCountInfoItem("皮肤",
                    () => state.cookieInfoCount.value.skinCount.toString()),
                SizedBox(height: 6.h),
                _cookieCountInfoItem("角色",
                    () => state.cookieInfoCount.value.operatorCount.toString()),
                SizedBox(height: 6.h),
                _cookieCountInfoItem("活动",
                    () => state.cookieInfoCount.value.activityCount.toString()),
                SizedBox(height: 6.h),
                _cookieCountInfoItem(
                    "EP", () => state.cookieInfoCount.value.epCount.toString())
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _cookieCountInfoItem(String label, String Function() count) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: DunColors.gray_1),
        ),
        SizedBox(width: 6.w),
        const Expanded(child: DashedLineHorizontalWidget()),
        SizedBox(width: 6.w),
        Obx(
          () => Text(
            count.call(),
            style: TextStyle(fontSize: 12.sp, color: DunColors.gray_1),
          ),
        ),
      ],
    );
  }

  Widget _cakeInfoRing() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(154.sp, 154.sp),
          painter: DashedCirclePainter(borderColor: DunColors.yellow),
        ),
        Column(
          children: [
            SizedBox(height: 33.h),
            Text(
              "HAVE FOUND",
              style: TextStyle(fontSize: 11.sp, color: DunColors.gray_1),
            ),
            Obx(
              () => Text(
                state.cookieInfoCount.value.totalCount == 0
                    ? "-----"
                    : state.cookieInfoCount.value.totalCount.toString(),
                style: TextStyle(fontSize: 44.sp, color: DunColors.gray_1),
              ),
            ),
            DashedLineHorizontalWidget(width: 68.w),
            SizedBox(height: 3.h),
            Text(
              "CAKE",
              style: TextStyle(fontSize: 16.sp, color: DunColors.yellow),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ],
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
