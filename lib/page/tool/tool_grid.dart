import 'package:animate_do/animate_do.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/time_unit.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/page/tool/tool_link.dart';
import 'package:dun_cookie_flutter/page/tool/tool_video.dart';
import 'package:flutter/material.dart';

class ToolGrid extends StatelessWidget {
  ToolGrid(
    this.title, {
    Key? key,
    this.type = 0,
    this.videoInfo,
    this.linkInfo,
  }) : super(key: key) {
    if (videoInfo != null) {
      // 视频信息过滤
      videoInfo = videoInfo!
          .where((element) => TimeUnit.isTimeRange(
              TimeUnit.utcChinaNow(), element.starTime, element.overTime))
          .toList();
    }
  }

  String title;
  int type; //0 为链接  1为视频
  List<BtnList>? videoInfo; // 视频数据
  List<dynamic>? linkInfo; // 链接数据

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: type == 0 ? linkInfo!.length : videoInfo!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: type == 0 ? 4 : 1),
            itemBuilder: (ctx, index) {
              return Card(
                child: type == 0
                    ? ToolLink(linkInfo![index])
                    : ToolVideo(videoInfo![index]),
              );
            },
          ),
        )
      ],
    );
  }
}
