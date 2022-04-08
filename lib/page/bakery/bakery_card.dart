import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/bakery_data.dart';
import 'package:dun_cookie_flutter/page/bakery/bakery_content_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("以下为示例样式，非最终样式，蜜饼工坊，敬请期待"),
              Text(
                data.description!,
                style: DunStyles.text16C,
              ),
              Text(
                "${data.createTime!}发布",
                style: DunStyles.text14,
              ),
              Text(
                data.createTime == null ? "暂未修改" : "于${data.modifyTime}修改",
                style: DunStyles.text14,
              ),
            ],
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
                  itemCount: data.daily!.length,
                  contentsBuilder: (_, index) {
                    BakeryDaily indexDay = data.daily![index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  indexDay.datetime!.toString(),
                                  style: DunStyles.text20C,
                                ),
                              ),
                              margin: const EdgeInsets.only(left: 5),
                            ),
                            ContentTimeLine(indexDay.info!),
                            const Divider(
                              height: 8,
                              color: DunColors.DunColor,
                            ),
                            indexDay.content!.isEmpty
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Html(
                                      data: indexDay.content!,
                                    ),
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
