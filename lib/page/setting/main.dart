import 'package:dun_cookie_flutter/page/info/main.dart';
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
          ListTile(
            title: const Text("建议反馈BUG提交"),
            subtitle: const Text("没事你也可以进来看看"),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, DunInfo.routerName);
            },
          ),
        ],
      ),
    );
  }
}
