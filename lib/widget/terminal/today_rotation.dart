import 'package:dun_cookie_flutter/common/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/time_unit.dart';
import '../../model/ceobe/resource/resource_info.dart';

class TodayResource extends StatelessWidget {
  const TodayResource(this.resources, {Key? key}) : super(key: key);

  final Resources resources;
  static List<Map<String, dynamic>> resourceInfo = [
    {
      "type": 1,
      "name": "高级作战记录",
      "day": [1, 2, 3, 4, 5, 6, 7],
      "src": Assets.image.resourceImage.ls.path
    },
    {
      "type": 2,
      "name": "龙门币",
      "day": [2, 4, 6, 7],
      "src": Assets.image.resourceImage.ce.path
    },
    {
      "type": 3,
      "name": "采购凭证",
      "day": [1, 4, 6, 7],
      "src": Assets.image.resourceImage.ap.path
    },
    {
      "type": 4,
      "name": "碳素",
      "day": [1, 3, 5, 6],
      "src": Assets.image.resourceImage.sk.path
    },
    {
      "type": 5,
      "name": "技巧概要",
      "day": [2, 3, 5, 7],
      "src": Assets.image.resourceImage.ca.path
    },
    {
      "type": 6,
      "name": "摧枯拉朽",
      "day": [1, 2, 5, 6],
      "src": Assets.image.resourceImage.prb.path
    },
    {
      "type": 7,
      "name": "身先士卒",
      "day": [2, 3, 6, 7],
      "src": Assets.image.resourceImage.prd.path
    },
    {
      "type": 8,
      "name": "固若金汤",
      "day": [1, 4, 5, 7],
      "src": Assets.image.resourceImage.pra.path
    },
    {
      "type": 9,
      "name": "势不可当",
      "day": [3, 4, 6, 7],
      "src": Assets.image.resourceImage.prc.path
    },
  ];

  //  计算是否开启
  bool resourcesNotToday(List<int> dayList) {
    DateTime dt = TimeUnit.utcChinaNow();
    if (TimeUnit.isTimeRange(dt, resources.startTime, resources.overTime)) {
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
    return Container(
      color: Colors.white,
      padding: REdgeInsets.symmetric(vertical: 3.5),
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: resourceInfo.map((element) {
          List<int> dayList = element["day"] as List<int>;
          String weekList = dayList.map((element) {
            return TimeUnit.numberToWeek(element);
          }).join(",");
          return Tooltip(
              message: "${element["name"]}:$weekList",
              child: resourcesNotToday(dayList)
                  ? Image.asset(
                      element["src"],
                      width: 46,
                      height: 46,
                    )
                  : Image.asset(
                      element["src"],
                      color: Colors.white24,
                      colorBlendMode: BlendMode.modulate,
                      width: 46,
                      height: 46,
                    ));
        }).toList(),
      ),
    );
  }
}
