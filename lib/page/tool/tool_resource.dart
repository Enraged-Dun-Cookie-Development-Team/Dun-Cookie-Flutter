import 'package:animate_do/animate_do.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:flutter/material.dart';

class ToolResource extends StatelessWidget {
  ToolResource(DayInfo? dayInfo, {Key? key}) {
    _resources = dayInfo != null ? dayInfo.resources! : null;
  }

  late final Resources? _resources;
  static bool openResources = false;
  static List<Map<String, dynamic>> resourceInfo = [
    {
      "type": 1,
      "name": "高级作战记录",
      "day": [1, 2, 3, 4, 5, 6, 7],
      "src": 'assets/image/resource_image/LS.png'
    },
    {
      "type": 2,
      "name": "龙门币",
      "day": [2, 4, 6, 7],
      "src": 'assets/image/resource_image/CE.png'
    },
    {
      "type": 3,
      "name": "采购凭证",
      "day": [1, 4, 6, 7],
      "src": 'assets/image/resource_image/AP.png'
    },
    {
      "type": 4,
      "name": "碳素",
      "day": [1, 3, 5, 6],
      "src": 'assets/image/resource_image/SK.png'
    },
    {
      "type": 5,
      "name": "技巧概要",
      "day": [2, 3, 5, 7],
      "src": 'assets/image/resource_image/CA.png'
    },
    {
      "type": 6,
      "name": "摧枯拉朽",
      "day": [1, 2, 5, 6],
      "src": 'assets/image/resource_image/PRB.png'
    },
    {
      "type": 7,
      "name": "身先士卒",
      "day": [2, 3, 6, 7],
      "src": 'assets/image/resource_image/PRD.png'
    },
    {
      "type": 8,
      "name": "固若金汤",
      "day": [1, 4, 5, 7],
      "src": 'assets/image/resource_image/PRA.png'
    },
    {
      "type": 9,
      "name": "势不可当",
      "day": [3, 4, 6, 7],
      "src": 'assets/image/resource_image/PRC.png'
    },
  ];

//  计算是否开启
  bool resourcesNotToday(List<int> dayList) {
    DateTime dt = TimeUnit.utcChinaNow();
    if (_resources != null &&
        TimeUnit.isTimeRange(dt, _resources!.starTime, _resources!.overTime)) {
      return true;
    }
    int week = dt.weekday;
    if (dt.hour <= 4) {
      week -= 1;
      if (week == 0) {
        week = 7;
      }
    }
    return dayList.contains(week);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, mainAxisSpacing: 2, crossAxisSpacing: 2),
            itemBuilder: (ctx, index) {
              List<int> dayList = resourceInfo[index]["day"] as List<int>;
              String weekList = dayList.map((element) {
                return TimeUnit.numberToWeek(element);
              }).join(",");
              return FadeInUp(
                delay: Duration(milliseconds: 50 * index),
                child: Tooltip(
                  message: "${resourceInfo[index]["name"]}:$weekList",
                  child: resourcesNotToday(dayList)
                      ? Image.asset(resourceInfo[index]["src"])
                      : Image.asset(
                          resourceInfo[index]["src"],
                          color: Colors.white24,
                          colorBlendMode: BlendMode.modulate,
                        ),
                ),
              );
            },
            itemCount: resourceInfo.length,
          ),
        ],
      ),
    );
  }
}
