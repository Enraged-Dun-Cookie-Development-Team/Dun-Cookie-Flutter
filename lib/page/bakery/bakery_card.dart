import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/page/bakery/bakery_content_timeline.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class BakeryCard extends StatelessWidget {
  BakeryCard(this.data, {Key? key}) : super(key: key);

  BakeryData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("以下为示例样式，非最终样式，蜜饼工坊，敬请期待"),
          Text(
            "${data.createTime!}发布，${data.updateTime == null ? "暂未修改" : "于${data.updateTime}修改"}",
            style: DunStyles.text14,
          ),
          Text(
            data.title!,
            style: DunStyles.text16C,
          ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FixedTimeline.tileBuilder(
                builder: TimelineTileBuilder.connected(
                  nodePositionBuilder: (_, index) => 0,
                  //距离左侧的距离
                  connectionDirection: ConnectionDirection.before,
                  // 方向
                  itemCount: data.day!.length,
                  contentsBuilder: (_, index) {
                    BakeryDay indexDay = data.day![index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(indexDay.datetime!.toString(),style: DunStyles.text20C,),
                              ),
                              margin: const EdgeInsets.only(left: 5),
                            ),
                            ContentTimeLine(indexDay.info!),
                            indexDay.content!.isEmpty
                                ? Container()
                                : Container(
                                    child: Text(
                                      indexDay.content!,
                                      style: DunStyles.text16C
                                          .copyWith(
                                              fontStyle: FontStyle.italic),
                                    ),
                                    margin: const EdgeInsets.all(8),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                  indicatorBuilder: (_, index) {
                    return const OutlinedDotIndicator(
                      size: 20.0, // 圆圈的大小
                      borderWidth: 2.5, // 圆圈的宽度
                      color: DunColors.BakeryColor, // 圆圈的颜色
                    );
                  },
                  connectorBuilder: (_, index, ___) => const SolidLineConnector(
                    thickness: 2.5, // 线的粗细
                    color: DunColors.BakeryColor, // 线的颜色
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
