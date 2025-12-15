import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../route.dart';
import 'dun_toast.dart';

//如果要添加新的 去搜索 app名称+UrlScheme
class DunJump {
  static openQQGroup() {
    DunJump.openAppOrWebPage(
        url:
            "https://qun.qq.com/universal-share/share?ac=1&authKey=lkbR6Q0cu87iULXXsW5KnRMei%2FsIIcLVZIzh1jlhySWT0JEfurmAyw91Nvh21E%2BK&busi_data=eyJncm91cENvZGUiOiI5MTc2MjU1NTkiLCJ0b2tlbiI6IlJkNTJsTjJnUU9EQTBuVWRmN01meHZjNWN6WU9LYmk2TlZUZ3RyYmYvb0RuNVlpR0pwMFhSZTFKakg0cjNBQXAiLCJ1aW4iOiIxMTU4MDI5MjcxIn0%3D&data=SRhF4r8f36JvHPE2PqTK5VV6rePM9a_jq-YYS15CFJSSv3BjT-HUpQp_eDv_h6VkopL7rwJrrwE5GTjjMx6Rkg&svctype=4&tempid=h5_group_info",
        appUrlScheme:
            "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=917625559&card_type=group&source=sharecard");
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
        await launchUrlString(appUrlScheme);
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
      await launchUrlString(appUrlScheme);
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

  /// 打开外部浏览器
  static Future<bool> openExternalWeb(String url) async {
    if (url.isEmpty) {
      DunToast.showInfo("无法访问空链接");
      return false;
    }
    return launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}
