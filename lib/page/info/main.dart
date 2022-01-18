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
                  "小刻食堂 alpha",
                  style: TextStyle(fontSize: 26),
                ),
                const Text(
                  "Powered By 蓝芷怡 & 洛梧藤",
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  "欢迎来QQ群【蹲饼组】反馈BUG或提出意见建议，一起来玩",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}