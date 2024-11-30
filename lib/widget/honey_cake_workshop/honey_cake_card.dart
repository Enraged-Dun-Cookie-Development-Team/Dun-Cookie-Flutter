import 'package:dun_cookie_flutter/common/dun_jump.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timelines/timelines.dart';

import '../../common/dun_color.dart';
import '../../model/bakery/bakery_data.dart';
import 'content_time_line.dart';

class HoneyCakeWorkshopCard extends StatelessWidget {
  const HoneyCakeWorkshopCard(this.model, {super.key});

  final BakeryDataModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (model.cvLink.isNotEmpty) {
                    DunJump.openAppOrWebPage(
                      url: "https://www.bilibili.com/read/cv${model.cvLink}",
                      appUrlScheme: "bilibili://article/${model.cvLink}",
                    );
                  }
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '饼学大厦 #${model.id}',
                          style: DunStyles.text20C,
                        ),
                        const SizedBox(width: 8),
                        const Image(
                          image: AssetImage("assets/sources_logo/bili.ico"),
                          height: 20,
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          "Bilibili专栏",
                          style: TextStyle(
                            color: DunColors.DunColorBlue,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      model.description.isNotEmpty
                          ? "（ver.${model.description}）"
                          : "",
                      style: DunStyles.text20C,
                    ),
                  ],
                ),
              ),
              Text(
                "${model.createTime}发布 ${model.createTime.isNotEmpty ? "暂未修改" : "于${model.modifyTime}修改"}",
                style: DunStyles.text12B,
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
                  itemCount: model.daily.length,
                  nodePositionBuilder: (_, index) => 0,
                  connectionDirection: ConnectionDirection.before,
                  contentsBuilder: (_, index) {
                    BakeryDaily indexDay = model.daily[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  indexDay.datetime.toString(),
                                  style: DunStyles.text20C,
                                ),
                              ),
                            ),
                            ContentTimeLine(indexDay.info),
                            indexDay.content.isEmpty
                                ? Container()
                                : const Divider(
                                    height: 8,
                                    color: DunColors.DunColor,
                                  ),
                            indexDay.content.isEmpty
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Html(
                                      data: indexDay.content,
                                    ),
                                  ),
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
