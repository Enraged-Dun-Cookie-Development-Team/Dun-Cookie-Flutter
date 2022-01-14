import 'package:card_swiper/card_swiper.dart';
import 'package:dun_cookie_flutter/cache/setting_cache.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/page/tool/tool_announcement.dart';
import 'package:dun_cookie_flutter/page/tool/tool_countdown.dart';
import 'package:dun_cookie_flutter/page/tool/tool_source_and_tool_and_video.dart';
import 'package:dun_cookie_flutter/service/info_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class DunTool extends StatefulWidget {
  const DunTool({Key? key}) : super(key: key);
  static String routeName = "/tool";

  @override
  State<DunTool> createState() => _DunToolState();
}

class _DunToolState extends State<DunTool> {
  bool? checkedBoxValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InfoRequest.getCeobecanteenInfo().then((value) =>
        Provider.of<CeobecanteenInfo>(context, listen: false)
            .setCeobecanteenInfo(value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // APP公告
        const ToolAnnouncement(),
        //活动公告
        Expanded(
          child: Consumer<CeobecanteenInfo>(
            builder: (context, data, child) {
              if (data.ceobecanteenInfo != null) {
                CeobecanteenInfo ceobecanteenInfo = data.ceobecanteenInfo!;
                print(ceobecanteenInfo.dayInfo!.countdown!.length);
                return ListView(
                  children: [
                    // 倒计时
                    if (ceobecanteenInfo.dayInfo != null &&
                        ceobecanteenInfo.dayInfo!.countdown != null)
                      ToolCountdown(ceobecanteenInfo.dayInfo!.countdown!),
                    // 官方源
                    ToolSourceAndTool("饼的发源地"),
                    // 快捷工具
                    if (ceobecanteenInfo.dayInfo != null)
                      ToolSourceAndTool("快捷工具"),
                    //推荐视频
                    if (ceobecanteenInfo.btnList != null)
                      ToolSourceAndTool("视频推荐",type: 1,videoInfo:ceobecanteenInfo.btnList)
                  ],
                );
              }
              return const Center(
                child: Text("正在获取，请稍后"),
              );
            },
          ),
        )
      ],
    );
  }
}
