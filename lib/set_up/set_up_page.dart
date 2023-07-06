import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/set_up/set_up_datasource_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/setting_provider.dart';

class SetUpPage extends StatefulWidget {
  const SetUpPage({Key? key}) : super(key: key);
  static String routerName = "/set_up";

  @override
  State<SetUpPage> createState() => _SetUpPageState();
}

class _SetUpPageState extends State<SetUpPage> {
  late SettingProvider settingData;
  @override
  void initState() {
    settingData = Provider.of<SettingProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray_3,
      appBar: AppBar(title: const Text("设置&其他")),
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
                  _buildThemeColorSwitch(),
                  _buildLine(),
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
                  _buildAboutUs(),
                  _buildLine(),
                  _buildFollowOnBilibili(),
                  _buildLine(),
                  _buildCheckUpgrade(),
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
            // 这里不知道为什么点不动
            settingData.appSetting.isPreview = !isPreview;
            settingData.saveAppSetting();
          },
        ),
      ],
    );
  }

  Widget _buildAboutUs() {
    return const Column(
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
    );
  }

  Widget _buildFollowOnBilibili() {
    return const Column(
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
    );
  }

  Widget _buildCheckUpgrade() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 7),
        Text(
          "检测升级",
          style: TextStyle(
            color: gray_1,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 2),
        Text(
          "可以试着点点",
          style: TextStyle(
            color: gray_subtitle,
            fontSize: 11,
          ),
        ),
        SizedBox(height: 7),
      ],
    );
  }
}
