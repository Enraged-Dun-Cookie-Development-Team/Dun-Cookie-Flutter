import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../route.dart';
import 'dun_toast.dart';

//如果要添加新的 去搜索 app名称+UrlScheme
class DunJump {
  // QQ群【蹲饼组】key
  static String qqGroupKey = "7J0JXjKHm4zs3lL09if3Ffy3ZK0otF1P";

  static openQQGroup() {
    DunJump.openAppOrWebPage(
        url:
            "https://qm.qq.com/cgi-bin/qm/qr?k=$qqGroupKey&jump_from=webapi&authKey=LW9kTeL9JU9pKJtyqgiexX/bNdvZQNhKqv2fVElymXVnxG4um2zJ6Iri7FRzqGyG",
        appUrlScheme:
            "mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26jump_from%3Dwebapi%26k%3D$qqGroupKey");
  }

  // b站账号【小刻食堂】uid
  static String bilibiliKey = "1723599428";

  static followInBilibili() {
    DunJump.openAppOrWebPage(
        url: "https://m.bilibili.com/space/$bilibiliKey",
        appUrlScheme: "bilibili://space/$bilibiliKey");
  }

  //打开app，失败后跳转至网页
  static openAppOrWebPage({String url = "", String appUrlScheme = ""}) async {
    if (appUrlScheme != "") {
      if (await canLaunchUrlString(appUrlScheme)) {
        DunToast.showSuccess("正在唤起APP");
        await launchUrl(Uri.dataFromString(appUrlScheme));
      } else {
        DunToast.showError("没有检测到APP，正在打开网页");
        // Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
        Get.toNamed(DunRouter.web, arguments: url);
      }
    } else if (url != "") {
      // Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
      Get.toNamed(DunRouter.web, arguments: url);
    }
  }

  //打开app
  static openAppUrlScheme(String appUrlScheme) async {
    if (await canLaunchUrlString(appUrlScheme)) {
      DunToast.showSuccess("正在唤起APP");
      await canLaunchUrlString(appUrlScheme);
    } else {
      DunToast.showError("没有检测到对应app");
    }
  }

  //打开网页
  static openWebPage(String url) async {
    if (url != "") {
      // Navigator.pushNamed(ctx, DunWebView.routeName, arguments: url);
      Get.toNamed(DunRouter.web, arguments: url);
    }
  }
}
