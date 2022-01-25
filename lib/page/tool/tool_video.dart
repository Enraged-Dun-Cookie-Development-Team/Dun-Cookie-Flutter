import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

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
            ),
          )
        ],
      ),
      onTap: () {
        _openBilibili(videoInfo.url!, context);
      },
    );
  }

  _openBilibili(url, context) async {
    var infoList = url!.split("video/");
    if (infoList.isNotEmpty && infoList.length >= 1) {
      String appUrl = "bilibili://video/${infoList[1]}";
      OpenAppOrBrowser.openUrl(url, context, appUrlScheme: appUrl);
    }
  }
}
