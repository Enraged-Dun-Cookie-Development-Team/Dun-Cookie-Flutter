import 'package:dun_cookie_flutter/common/browser/main.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_info.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolLink extends StatelessWidget {
  ToolLink(this.linkInfo, {Key? key});

  dynamic linkInfo;
  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    late String url;
    late String image;
    late String title;
    String? jumpApp;

    if (linkInfo is SourceInfo) {
      url = linkInfo.jumpUrl;
      image = linkInfo.icon;
      title = linkInfo.title;
      jumpApp = linkInfo.jumpApp;
    }
    if (linkInfo is QuickJump) {
      url = linkInfo.url;
      image = linkInfo.img;
      title = linkInfo.name;
    }
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                child: Image.asset(
                  image,
                  width: 30,
                ),
                borderRadius: BorderRadius.circular(4)),
            const SizedBox(
              width: 5,
            ),
            Text(title)
          ],
        ),
      ),
      onTap: () {
        _openApp(url: url, jumpApp: jumpApp);
      },
    );
  }

  _openApp({url, jumpApp}) async {
    if (jumpApp != null && await canLaunch(jumpApp)) {
      DunToast.showSuccess("正在唤起APP");
      await launch(jumpApp);
    } else {
      _goSource(url);
    }
  }

  _goSource(url) {
    Navigator.pushNamed(_context!, DunWebView.routeName, arguments: url);
  }
}