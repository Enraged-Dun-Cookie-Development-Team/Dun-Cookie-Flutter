import 'package:dun_cookie_flutter/common/browser/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  static String routerName = "/donation_page";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        eventBus.fire(ChangeSourceBus());
        return true;
      },
      child: Scaffold(
        backgroundColor: gray_3,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => {Navigator.of(context).pop('刷新')}),
          leadingWidth: 50,
          iconTheme: const IconThemeData(
            color: DunColors.DunColor,
          ),
          titleTextStyle:
              const TextStyle(color: DunColors.DunColor, fontSize: 20),
          titleSpacing: 0,
          elevation: 0,
          title: const Text("支持我们"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 58),
              const Text(
                "感谢大家对小刻食堂的支持",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text("未成年刀客塔请勿捐款，三连我们的账号就可以啦~"),
              const SizedBox(height: 24),
              const Text("如果在收支一览表内没有发现自己的捐助，"),
              const Text("那就是我们理智涣散了，"),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => OpenAppOrBrowser.openQQGroup(context),
                    child: const Text(
                      "来群里",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: DunColors.DunColor),
                    ),
                  ),
                  const Text("找我们添加！"),
                ],
              ),
              const SizedBox(height: 24),
              const Text("由于捐助列表是程序自动生成"),
              const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("捐助的备注一定要以"),
                  Text(
                    "刻",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: DunColors.DunColor),
                  ),
                  Text("字开头哦"),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 158,
                width: double.infinity,
                child: Stack(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(width: 50),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("点"),
                            Text("击"),
                            Text("这"),
                            Text("里"),
                          ],
                        ),
                        Icon(Icons.arrow_right_alt),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => OpenAppOrBrowser.followInBilibili(context),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: const Column(children: [
                          Image(
                            image: AssetImage("assets/image/bilibili.jpeg"),
                            width: 100,
                          ),
                          Text("关注我们的b站账号"),
                          Text("欢迎大会员每月5B币的充电")
                        ]),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => DunToast.showInfo("长按保存二维码"),
                    onLongPress: () async {
                      final ByteData bytes =
                          await rootBundle.load("assets/image/wechat_new.jpg");
                      await ImageGallerySaver.saveImage(
                          bytes.buffer.asUint8List());
                      DunToast.showInfo("保存成功!");
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage("assets/image/wechat_new.jpg"),
                            width: 100,
                          ),
                          SizedBox(height: 4),
                          Text("微信"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => DunToast.showInfo("长按保存二维码"),
                    onLongPress: () async {
                      final ByteData bytes =
                          await rootBundle.load("assets/image/zfb_new.jpg");
                      await ImageGallerySaver.saveImage(
                          bytes.buffer.asUint8List());
                      DunToast.showInfo("保存成功!");
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage("assets/image/zfb_new.jpg"),
                            width: 100,
                          ),
                          SizedBox(height: 4),
                          Text("支付宝"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, DunWebView.routeName,
                    arguments:
                        "https://shimo.im/sheets/NJkbEgRmQRtpQ7qR/MODOC"),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: DunColors.DunColor,
                  ),
                  child: const Text(
                    "收支一览表",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
