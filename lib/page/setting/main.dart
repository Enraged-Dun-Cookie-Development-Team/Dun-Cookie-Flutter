import 'package:dun_cookie_flutter/page/setting/setting_source_filter.dart';
import 'package:flutter/material.dart';

class DunSetting extends StatelessWidget {
  const DunSetting({Key? key}) : super(key: key);

  static String routerName = "/setting";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("饼来源"),
            subtitle: const Text("选择勾选来源，最少选择一个"),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, SettingSourceFilter.routerName);
            },
          ),
          _info(),
        ],
      ),
    );
  }

//  信息
  _info() {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 3,
            color: Colors.black45,
          ),
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
    );
  }
}
