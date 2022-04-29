import 'dart:typed_data';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../common/tool/open_app_or_browser.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  static String routerName = "/donate";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DunToast.showError("感谢支持");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("小刻食堂 - 感谢你的捐助"),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  width: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "感谢你使用小刻食堂",
                  style: DunStyles.text20C,
                ),
                const Text(
                  "更感谢你进入到这个页面",
                  style: DunStyles.text20C,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "这是一个捐助页面，资金动向我们会公示。",
                  style: DunStyles.text14C.copyWith(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    OpenAppOrBrowser.openAppUrlScheme(
                        "https://shimo.im/sheets/NJkbEgRmQRtpQ7qR/zYa7U/",
                        context);
                  },
                  child: const Text("小刻食堂收支一览"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "这是一句卖惨的话，请各位脑补",
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF1678FF))),
                        onPressed: () {
                          OpenAppOrBrowser.openAppUrlScheme(
                              "https://qr.alipay.com/fkx13609vogweykl84mgj79",
                              context);
                        },
                        child: const Text("打开支付宝")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF00B600))),
                        onPressed: () async {
                          ByteData bytes =
                              await rootBundle.load('assets/image/wechat.jpg');
                          Uint8List imageBytes = bytes.buffer.asUint8List();
                          final result =
                              await ImageGallerySaver.saveImage(imageBytes);
                          if (result == null || result == '') {
                            DunToast.showError('图片保存失败');
                          } else {
                            DunToast.showSuccess("保存成功");
                          }
                        },
                        child: const Text("下载微信收款码")),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF00B600))),
                        onPressed: () async {
                          OpenAppOrBrowser.openAppUrlScheme(
                              "weixin://", context);
                        },
                        child: const Text("打开微信")),
                  ],
                ),
                const Text(
                  "支付宝会跳转到浏览器打开支付宝APP",
                  style: TextStyle(color: Color(0xFF1678FF)),
                ),
                const Text(
                  "微信需要下载收款码微信内打开相册扫码支付",
                  style: TextStyle(color: Color(0xFF00B600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
