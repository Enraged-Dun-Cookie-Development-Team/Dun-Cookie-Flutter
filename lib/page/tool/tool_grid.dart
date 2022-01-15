import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/page/tool/tool_video.dart';
import 'package:flutter/material.dart';

class ToolGrid extends StatelessWidget {
  ToolGrid(
    this.title, {
    Key? key,
    this.type = 0,
    this.videoInfo,
  }) : super(key: key);

  String title;
  int type; //0 为链接  1为视频
  List<BtnList>? videoInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: DunColors.DunColor, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: type == 0 ? 5 : videoInfo!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: type == 0 ? 5 : 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (ctx, index) {
              return Card(
                child: type == 0
                    ? Center(
                        child: Text(index.toString()),
                      )
                    : ToolVideo(videoInfo![index]),
              );
            },
          ),
        )
      ],
    );
  }
}
