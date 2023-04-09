import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_circle_widget.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_line_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/ui/item_card_left_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/ui/set_up_button_widget.dart';
import 'package:dun_cookie_flutter/main_page/terminal_page/ui/today_rotation.dart';
import 'package:dun_cookie_flutter/model/resource_info.dart';
import 'package:dun_cookie_flutter/request/tools_api.dart';
import 'package:flutter/material.dart';

import 'ui/prts_title_widget.dart';

class TerminalPageWidget extends StatefulWidget {
  const TerminalPageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TerminalPageWidgetState();
}

class _TerminalPageWidgetState extends State<TerminalPageWidget> {
  ResourceInfo? resourceInfo;

  @override
  void initState() {
    super.initState();
    ToolsApi.getResourceInfo().then((value) => setState(() => resourceInfo = value));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      _buildCakeWarehouse(),
      const SizedBox(height: 15),
      _buildResourceWidget(),
    ];
    for (Countdown countdown in resourceInfo?.countdown ?? []) {
      if (TimeUnit.isTimeRange(TimeUnit.utcChinaNow(), countdown.startTime, countdown.overTime)) {
        listWidget.add(const SizedBox(height: 15));
        listWidget.add(_buildActivityWidget(countdown));
      }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
      children: const [
        Expanded(child: PrtsTitleWidget()),
        SizedBox(width: 8),
        SetUpButtonWidget(),
      ],
    );
  }

  Widget _buildCakeWarehouse() {
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
                  Positioned(
                    left: 24,
                    top: 7,
                    child: Column(
                      children: const [
                        Text(
                          "已发现饼的数量",
                          style: TextStyle(
                            color: gray_1,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 3),
                        DashedLineWidget(width: 112),
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
                          children: const [
                            Text(
                              "皮肤",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6),
                            DashedLineWidget(width: 51),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Text(
                              "角色",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6),
                            DashedLineWidget(width: 51),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Text(
                              "活动",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6),
                            DashedLineWidget(width: 51),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Text(
                              "EP",
                              style: TextStyle(
                                fontSize: 12,
                                color: gray_1,
                              ),
                            ),
                            SizedBox(width: 6),
                            DashedLineWidget(width: 51),
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
                          Center(
                            child: Column(
                              children: const [
                                SizedBox(height: 33),
                                Text(
                                  "HAVE FOUND",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: gray_1,
                                  ),
                                ),
                                SizedBox(height: 60),
                                DashedLineWidget(width: 68),
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
                          const Center(
                            child: Text(
                              "12345",
                              style: TextStyle(
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
    return SizedBox(
      height: 97,
      child: Row(
        children: [
          const ItemCardLeftWidget(
            columnText: "WEEK",
            titleText: "星期",
            centerText: "三",
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              color: white,
              child: TodayResource(resourceInfo?.resources),
            ),
          ),
        ],
      ),
    );
  }

  // 活动信息
  Widget _buildActivityWidget(Countdown? countdown) {
    return SizedBox(
      height: 97,
      child: Row(
        children: [
          const ItemCardLeftWidget(
            columnText: "EVENT",
            titleText: "活动剩余",
            centerText: "16",
            labelColor: red,
            isDays: true,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Container(
              color: white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(countdown?.text ?? ""),
                    Text(countdown?.remark ?? ""),
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
