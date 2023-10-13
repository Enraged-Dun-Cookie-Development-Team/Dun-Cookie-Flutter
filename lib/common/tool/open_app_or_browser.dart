import 'package:dun_cookie_flutter/page/webview/main.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//如果要添加新的 去搜索 app名称+UrlScheme
class OpenAppOrBrowser {
  // QQ群【蹲饼组】key
  static String qqGroupKey = "7J0JXjKHm4zs3lL09if3Ffy3ZK0otF1P";
  static openQQGroup(BuildContext context) {
    OpenAppOrBrowser.openUrl(
        "https://qm.qq.com/cgi-bin/qm/qr?k=$qqGroupKey&jump_from=webapi&authKey=LW9kTeL9JU9pKJtyqgiexX/bNdvZQNhKqv2fVElymXVnxG4um2zJ6Iri7FRzqGyG",
        context,
        appUrlScheme:
            "mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26jump_from%3Dwebapi%26k%3D$qqGroupKey");
  }

  // b站账号【小刻食堂】uid
  static String bilibiliKey = "1723599428";
  static followInBilibili(BuildContext context) {
    OpenAppOrBrowser.openUrl(
        "https://m.bilibili.com/space/$bilibiliKey", context,
        appUrlScheme: "bilibili://space/$bilibiliKey");
  }

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
