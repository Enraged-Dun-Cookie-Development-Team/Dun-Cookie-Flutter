import 'package:dun_cookie_flutter/common/constant/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/page/setting/setting_info.dart';
import 'package:dun_cookie_flutter/page/setting/setting_source_filter.dart';
import 'package:dun_cookie_flutter/page/update/main.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DunSetting extends StatefulWidget {
  const DunSetting({Key? key}) : super(key: key);

  static String routerName = "/setting";
  static bool isPreview = true;
  static int darkMode = 0;

  @override
  State<DunSetting> createState() => _DunSettingState();
}

class _DunSettingState extends State<DunSetting> {
  @override
  void initState() {
    setState(() {
      DunSetting.isPreview =
          Provider.of<SettingProvider>(context, listen: false)
              .appSetting
              .isPreview!;
      DunSetting.darkMode = Provider.of<SettingProvider>(context, listen: false)
              .appSetting
              .darkMode ??
          0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "本程序未经过多轮测试，如果有bug和闪退，请于下面反馈通道反馈",
            style: DunStyles.text16C,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "已内置推送，但是未启用新饼推送，如果收到推送，是我们在测试，不是正式数据",
            style: DunStyles.text16C,
          ),
        ),
        ListTile(
          title: const Text("饼来源"),
          subtitle: const Text("选择勾选来源，最少选择一个"),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {
            Navigator.pushNamed(context, SettingSourceFilter.routerName);
          },
        ),
        ListTile(
            title: Text("浅色/深色模式切换"),
            subtitle: Text("是否跟随系统切换模式"),
            trailing: DropdownButton<int>(
                value: DunSetting.darkMode,
                items: [
                  DropdownMenuItem(
                      child: Row(
                          children: const [Icon(Icons.settings), Text('跟随系统')]),
                      value: 0),
                  DropdownMenuItem(
                      child: Row(
                          children: const [Icon(Icons.wb_sunny), Text('浅色模式')]),
                      value: 1),
                  DropdownMenuItem(
                      child: Row(children: const [
                        Icon(Icons.shield_moon),
                        Text('深色模式')
                      ]),
                      value: 2)
                ],
                onChanged: (value) {
                  var settingProvider =
                      Provider.of<SettingProvider>(context, listen: false);
                  settingProvider.appSetting.darkMode = value;
                  settingProvider.saveAppSetting();
                  setState(() {
                    DunSetting.darkMode = value ?? 0;
                  });
                })),
        ListTile(
          title: const Text("省流模式"),
          subtitle: const Text("列表使用略缩图"),
          trailing: Switch(
            value: DunSetting.isPreview,
            onChanged: (value) {
              var settingProvider =
                  Provider.of<SettingProvider>(context, listen: false);
              settingProvider.appSetting.isPreview = value;
              settingProvider.saveAppSetting();
              setState(() {
                DunSetting.isPreview = value;
              });
            },
          ),
        ),
        const Divider(
          height: 6.0,
          indent: 0.0,
          color: Colors.black26,
        ),
        ListTile(
          title: const Text("关于我们"),
          subtitle: const Text("建议反馈BUG提交吹水扯淡"),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {
            Navigator.pushNamed(context, DunInfo.routerName);
          },
        ),
        ListTile(
          title: const Text("关于B站账号"),
          subtitle: const Text("欢迎关注我们"),
          trailing: const Icon(Icons.arrow_right),
          onTap: () {
            OpenAppOrBrowser.openUrl(
                "https://m.bilibili.com/space/1723599428", context,
                appUrlScheme: "bilibili://space/1723599428");
          },
        ),
        const Divider(
          height: 6.0,
          indent: 0.0,
          color: Colors.black26,
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
                double.parse(app!.version!) > double.parse(Constant.version)) {
              Navigator.pushNamed(context, DunUpdate.routerName,
                  arguments: app);
            } else {
              DunToast.showSuccess("当前版本是最新版本");
            }
          },
        ),
        const Divider(
          height: 6.0,
          indent: 0.0,
          color: Colors.black26,
        ),
        ListTile(
          title: Text(Constant.mobRId == null ? '--' : Constant.mobRId!),
          subtitle: const Text("推送ID，收不到推送请复制ID联系我们，没有ID也联系我们"),
          trailing: const Icon(Icons.handyman),
          onTap: () {
            Clipboard.setData(ClipboardData(text: Constant.mobRId));
            DunToast.showSuccess("已复制");
          },
        ),
      ],
    );
  }
}
