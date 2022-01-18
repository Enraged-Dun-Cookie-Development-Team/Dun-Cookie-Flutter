import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dun_cookie_flutter/common/browser/main.dart';

class OpenAppOrBrowser {
  static openUrl(String url, BuildContext ctx, {String? appUrlScheme}) async {
    if (appUrlScheme != null) {
      if (await canLaunch(appUrlScheme)) {
        DunToast.showSuccess("正在唤起APP");
        await launch(appUrlScheme);
      } else {
        DunToast.showError("没有检测到APP，正在打开网页");
        Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
      }
    } else {
      Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
    }
  }
}