import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../common/dun_color.dart';
import '../../model/bakery/bakery_data.dart';

class ContentTimeLine extends StatelessWidget {
  const ContentTimeLine(this.infoList, {super.key});

  final List<BakeryInfo> infoList;

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder(
        nodePositionBuilder: (_, index) => 0.06,
        //圆圈样式
        indicatorBuilder: (_, index) {
          if (infoList[index].forecastStatus.isNotEmpty &&
              infoList[index].forecastStatus != "unknown") {
            return DotIndicator(
              color: infoList[index].forecastStatus == "true"
                  ? Colors.green
                  : Colors.red,
              child: Icon(
                infoList[index].forecastStatus == "true"
                    ? Icons.done
                    : Icons.close,
                color: Colors.white,
                size: 14,
              ),
            );
          } else {
            return const OutlinedDotIndicator(
              borderWidth: 1.5,
              color: DunColors.dunColor,
            );
          }
        },
        //首尾相连
        startConnectorBuilder: (_, index) => const SolidLineConnector(
          thickness: 0.5,
          color: Colors.black45,
        ),
        endConnectorBuilder: (_, index) => index != infoList.length - 1
            ? const SolidLineConnector(
                thickness: 0.5,
                color: Colors.black45,
              )
            : null,
        //中间内容
        contentsBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.all(6),
            child: Text(infoList[index].forecast),
          );
        },
        // itemExtentBuilder: (_, index) => 30,
        // nodeItemOverlapBuilder: (_, index) => true, // 先穿过圈
        itemCount: infoList.length,
      ),
    );
  }
}
