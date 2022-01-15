import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolVideo extends StatelessWidget {
  ToolVideo(this.videoInfo, {Key? key}) : super(key: key);

  BtnList videoInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ExtendedImage.network(
              videoInfo.img!,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              videoInfo.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
      onTap: () {
        _openBilibili(videoInfo.url!);
      },
    );
  }

  _openBilibili(url) async {
    var infoList = url!.split("video/");
    if (infoList.isNotEmpty && infoList.length >= 1) {
      String tempUrl = "bilibili://video/${infoList[1]}";
      if (await canLaunch(tempUrl)) {
        DunToast.showSuccess("正在唤起APP");
        await launch(tempUrl);
      } else {
        DunToast.showSuccess("没有检测到APP，正在打开网页");
        await launch(url);
      }
    }
  }
}
