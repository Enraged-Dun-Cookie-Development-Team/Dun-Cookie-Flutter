import 'dart:io';

import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/constant/main.dart';
import '../../common/tool/dun_toast.dart';
import '../../common/tool/package_info.dart';
import '../datasource/set_up_datasource_page.dart';
import '../update/main.dart';
import '../../provider/setting_provider.dart';
import '../../request/info_request.dart';

class SetUpPage extends StatefulWidget {
  const SetUpPage({Key? key}) : super(key: key);
  static String routerName = "/set_up";

  @override
  State<SetUpPage> createState() => _SetUpPageState();
}

class _SetUpPageState extends State<SetUpPage> {
  String version = '0.0.0';
  late SettingProvider settingData;

  void init() async {
    version = await PackageInfoPlus.getVersion();
    setState(() {
      version = version;
    });
  }

  @override
  void initState() {
    settingData = Provider.of<SettingProvider>(context, listen: false);
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray_3,
      appBar: AppBar(
          //设置&其他页面
          // elevation: 0,
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
          title: const Text("设置&其他")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ],
                color: white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _buildCakeSource(context),
                  _buildLine(),
                  // _buildThemeColorSwitch(),
                  // _buildLine(),
                  _buildSaveFlow(),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 5,
                  ),
                ],
                color: white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutUs(context),
                  _buildLine(),
                  _buildFollowOnBilibili(context),
                  _buildLine(),
                  _buildCheckUpgrade(),
                  _buildLine(),
                  _buildDonation(),
                  _buildLine(),
                  _buildMobId(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      height: 1,
      color: gray_3,
    );
  }

  Widget _buildCakeSource(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SetUpDatasource()),
            ),
        child: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7),
                Text(
                  "饼来源",
                  style: TextStyle(
                    color: gray_1,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "选择勾选来源，最少选择一个",
                  style: TextStyle(
                    color: gray_subtitle,
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 7),
              ],
            ),
            Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
          ],
        ));
  }

  Widget _buildThemeColorSwitch() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "浅色/深色模式切换",
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "是否跟随系统切换模式",
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
        const Expanded(child: SizedBox()),
        Switch(
          value: true,
          onChanged: (isCheck) {},
        ),
      ],
    );
  }

  Widget _buildSaveFlow() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "省流模式",
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "列表使用缩略图",
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
        const Expanded(child: SizedBox()),
        Switch(
          value: settingData.appSetting.isPreview!,
          onChanged: (isPreview) {
            settingData.appSetting.isPreview = isPreview;
            settingData.saveAppSetting();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildAboutUs(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => OpenAppOrBrowser.openQQGroup(context),
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "关于我们",
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "建议反馈 BUG提交 吹水扯淡",
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowOnBilibili(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => OpenAppOrBrowser.followInBilibili(context),
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "关注b站账号",
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "欢迎关注我们",
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckUpgrade() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        DunApp? app = await InfoRequest.getAppVersionInfo();
        if (app.version != null &&
            await PackageInfoPlus.isVersionHigherThenNow(app.version)) {
          //跳转更新
          DunToast.showInfo("当前版本已过时，为您跳转到更新页面");
          Navigator.pushNamed(context, DunUpdate.routerName, arguments: app);
        } else {
          DunToast.showSuccess("当前版本是最新版本");
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "检查更新",
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              version,
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  Widget _buildDonation() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        //网页跳转
        if (Platform.isIOS) {
          String nowVersion = await PackageInfoPlus.getVersion();
          print("https://www.ceobecanteen.top/?version=$nowVersion&position=mo-sponsor");
          OpenAppOrBrowser.openUrl(
              "https://www.ceobecanteen.top/?version=$nowVersion&position=mo-sponsor",
              context);
        } else {
          OpenAppOrBrowser.openUrl(
              "https://www.ceobecanteen.top/?&position=mo-sponsor", context);
        }
      },
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "支持我们",
              style: TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "捐赠渠道",
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  Widget _buildMobId() {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: Constant.mobRId ?? '--'));
        DunToast.showSuccess("已复制");
      },
      highlightColor: Colors.blue,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 7),
            Text(
              Constant.mobRId ?? "--",
              style: const TextStyle(
                color: gray_1,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "推送ID，收不到推送请点击复制ID联系我们，没有ID也联系我们",
              style: TextStyle(
                color: gray_subtitle,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
