import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/page/setting/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../common/tool/package_info.dart';

class DunInfo extends StatelessWidget {
  const DunInfo({Key? key}) : super(key: key);
  static String routerName = "/dunInfo";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo/logo.png",
                width: 100,
              ),
              const SizedBox(
                height: 6,
              ),
              FutureBuilder<String>(
                  future: PackageInfoPlus.getVersion(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return Text(
                        '小刻食堂 Beta V' + snapshot.data!,
                        style: DunStyles.text26C,
                      );
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Flutter By 蓝芷怡",
              ),
              const Text(
                "NodeJS By 云闪",
              ),
              const Text(
                "后台 By 洛梧藤 & 凊弦凝绝",
              ),
              const Text(
                "画师 By 不画涩图の企鹅",
              ),
              const Text(
                "宣发 By 不到60kg不改名",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "欢迎联系我们为小刻食堂添砖加瓦",
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "欢迎来QQ群【蹲饼组】反馈BUG或提出意见建议",
              ),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: '362860473'));
                  DunToast.showSuccess("根本难不倒他");
                },
                child: const Text(
                  "群号：362860473，点击复制",
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
