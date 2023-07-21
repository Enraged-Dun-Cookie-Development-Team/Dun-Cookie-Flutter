import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/video_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ToolVideo extends StatelessWidget {
  ToolVideo(this.videoInfo, {Key? key}) : super(key: key);

  VideoModel videoInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ExtendedImage.network(
              videoInfo.coverImg!,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              videoInfo.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: DunStyles.text12,
            ),
          ),
          Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                child: Text(
                  videoInfo.author!,
                  maxLines: 1,
                  style: DunStyles.text12,
                ),
              )
          )
        ],
      ),
      onTap: () {
        _openBilibili(videoInfo.videoLink!, context);
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
