import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DunInfo extends StatelessWidget {
  const DunInfo({Key? key}) : super(key: key);
  static String routerName = "/dunInfo";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 300,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/logo/logo.png",
                  width: 100,
                ),
                const Text(
                  "小刻食堂 V${StaticVariable.version}",
                  style: DunStyles.text18C,
                ),
                const Text(
                  "Powered By 蓝芷怡 & 洛梧藤",
                ),
                const Text(
                  "欢迎来QQ群【蹲饼组】反馈BUG或提出意见建议，一起来玩",
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: '362860473'));
                    DunToast.showSuccess("已复制，来QQ群找我们聊天吧！");
                  },
                  child: const Text(
                    "群号：362860473，点击复制",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
