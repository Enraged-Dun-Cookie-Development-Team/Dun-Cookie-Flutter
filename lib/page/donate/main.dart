import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      child: MaterialApp(
        theme: DunTheme.themeList[0],
        title: "小刻食堂",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("小刻食堂 - 感谢你的捐助"),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo/logo.png",
                    width: 100,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "感谢你使用小刻食堂",
                    style: DunStyles.text20C,
                  ), const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "更感谢你进入到这个页面",
                    style: DunStyles.text20C,
                  ), const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "这是一个捐助页面，资金动向我们会公示。",
                    style: DunStyles.text14C.copyWith(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "这是一句卖惨的话，请各位脑补",
                  ),
                  const SizedBox(
                    height: 6,
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
                          child: const Text("支付宝捐助")),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF00B600))),
                          onPressed: () {
                            OpenAppOrBrowser.openAppUrlScheme(
                                "wxp://f2f0fEC4WDCnnPg_CHqtF7nCFa8jW8Z_WhTey7yHLVek26k",
                                context);
                          },
                          child: const Text("微信捐助")),
                    ],
                  ),
                  const Text("感谢支持")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
