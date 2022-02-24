import 'package:dun_cookie_flutter/common/static_variable/main.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/page/setting/setting_info.dart';
import 'package:dun_cookie_flutter/page/setting/setting_source_filter.dart';
import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DunSetting extends StatelessWidget {
  const DunSetting({Key? key}) : super(key: key);

  static String routerName = "/setting";

  @override
  Widget build(BuildContext context) {
    return Column(
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
          title: const Text("检测升级"),
          subtitle: const Text("可以试着点点"),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {
            DunApp? app = Provider.of<CeobecanteenData>(context, listen: false)
                .ceobecanteenInfo
                ?.app;
            if (app?.version != null &&
                double.parse(app!.version!) >
                    double.parse(StaticVariable.version)) {
              Navigator.pushNamed(context, DunUpdate.routerName,
                  arguments: app);
            } else {
              DunToast.showSuccess("当前版本是最新版本");
            }
          },
        ),
        ListTile(
          title: const Text("建议反馈BUG提交吹水扯淡"),
          subtitle: const Text("欢迎进群"),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {
            Navigator.pushNamed(context, DunInfo.routerName);
          },
        ),
      ],
    );
  }
}
