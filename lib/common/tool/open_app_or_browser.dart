import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dun_cookie_flutter/common/browser/main.dart';

//如果要添加新的 去搜索 app名称+UrlScheme
class OpenAppOrBrowser {
  static openUrl(String url, BuildContext ctx, {String? appUrlScheme}) async {
    if (appUrlScheme != null && appUrlScheme != "") {
      if (await canLaunch(appUrlScheme)) {
        DunToast.showSuccess("正在唤起APP");
        await launch(appUrlScheme);
      } else {
        DunToast.showError("没有检测到APP，正在打开网页");
        Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
      }
    } else if (url != "") {
      Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
    }
  }

  static openAppUrlScheme(String appUrlScheme, BuildContext ctx) async {
    if (await canLaunch(appUrlScheme)) {
      DunToast.showSuccess("正在唤起APP");
      await launch(appUrlScheme);
    } else {
      DunToast.showError("没有检测到对应app");
    }
  }
}
