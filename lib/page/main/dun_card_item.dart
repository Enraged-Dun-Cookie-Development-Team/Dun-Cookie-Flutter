import 'package:animate_do/animate_do.dart';
import 'package:dun_cookie_flutter/common/browser/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:dun_cookie_flutter/page/main/dun_content.dart';
import 'package:dun_cookie_flutter/page/main/dun_headren.dart';
import 'package:dun_cookie_flutter/page/main/dun_image.dart';
import 'package:flutter/material.dart';

class DunCardItem extends StatefulWidget {
  DunCardItem({Key? key, required this.info, required this.index})
      : super(key: key);
  SourceData info;
  int index; // 列表的第几个
  @override
  _DunCardItemState createState() => _DunCardItemState();
}

class _DunCardItemState extends State<DunCardItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SourceData info = widget.info;
    return GestureDetector(
      onTap: () => _goSource(info.jumpUrl),
      child: FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: Column(
          children: [
            DunHead(info),
            // const Divider(
            //   height: 8,
            //   color: DunColors.DunColor,
            //   endIndent: 200,
            // ),
            DunContent(info),
            DunImage(info),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.black26,
            )
          ],
        ),
      ),
    );
  }

  // 浏览器打开
  void _goSource(url) {
    int priority = widget.info.sourceInfo!.priority!;
    String appUrl = "";
    if (priority == 0) {
      // bilibili
      var id = url.split('/').last;
      appUrl = "bilibili://following/detail/$id";
    } else if (priority == 1 ||
        priority == 3 ||
        priority == 4 ||
        priority == 6 ||
        priority == 10) {
      // weibo
      var id = url.split('/').last;
      appUrl = "sinaweibo://detail?mblogid=$id";
    } else if (priority == 9) {
      // 网易云音乐
      var id = url.split('/').last.split('=').last.toString();
      appUrl = "orpheus://album/$id";
    }
    // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
    OpenAppOrBrowser.openUrl(url, context, appUrlScheme: appUrl);
  }
}
