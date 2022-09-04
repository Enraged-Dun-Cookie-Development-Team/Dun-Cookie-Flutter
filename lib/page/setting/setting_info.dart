import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/component/group_num_button.dart';
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
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                "Flutter By 蓝芷怡 & 滑稽",
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
              const GroupNumButton(toastContent: "根本难不倒他"),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
