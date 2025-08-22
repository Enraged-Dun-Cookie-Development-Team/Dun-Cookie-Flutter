import 'package:dun_cookie_flutter/manager/update_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import 'logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final logic = Get.put(SettingLogic());
  final state = Get.find<SettingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: DunColors.gray_3,
          appBar: AppBar(
              //设置&其他页面
              // elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: logic.onTapBack),
              leadingWidth: 50,
              iconTheme: const IconThemeData(
                color: DunColors.dunColor,
              ),
              titleTextStyle:
                  const TextStyle(color: DunColors.dunColor, fontSize: 20),
              titleSpacing: 0,
              title: const Text("设置&其他")),
          body: Padding(
            padding: REdgeInsets.fromLTRB(16, 16, 16, 5),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
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
                          color: DunColors.white,
                        ),
                        padding: REdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            _buildCakeSource(),
                            _buildLine(),
                            _buildSaveFlow(),
                            _buildLine(),
                            _buildHideBottomOnScrollSwitch(),
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
                          color: DunColors.white,
                        ),
                        padding: REdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAboutUs(),
                            _buildLine(),
                            _buildFollowOnBilibili(),
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
                )),
                _buildRecord(),
              ],
            ),
          ),
        ));
  }

  Widget _buildLine() {
    return Container(
      height: 1,
      color: DunColors.gray_3,
    );
  }

  Widget _buildCakeSource() {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: logic.onTapDataSourceSetting,
        child: const Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7),
                Text(
                  "饼来源",
                  style: TextStyle(
                    color: DunColors.gray_1,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "选择勾选来源，最少选择一个",
                  style: TextStyle(
                    color: DunColors.graySubtitle,
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

  Widget _buildSaveFlow() {
    return _buildItem(
      title: '省流模式',
      subtitle: '列表使用缩略图',
      trailing: Obx(() => Switch(
            activeColor: DunColors.dunColor,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.white,
            value: state.isPreview.value,
            onChanged: logic.onTapPreviewSwitch,
          )),
    );
  }

  Widget _buildHideBottomOnScrollSwitch() {
    return _buildItem(
      title: '向下滚动时隐藏底栏',
      subtitle: '向上滚动显示',
      trailing: Obx(() => Switch(
            activeColor: DunColors.dunColor,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.white,
            value: state.isHideBottomOnScroll.value,
            onChanged: logic.onTapHideBottomOnScrollSwitch,
          )),
    );
  }

  Widget _buildItem({
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 7),
            Text(
              title,
              style: const TextStyle(
                color: DunColors.gray_1,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            if (subtitle?.isNotEmpty == true)
              Text(
                subtitle ?? '',
                style: const TextStyle(
                  color: DunColors.graySubtitle,
                  fontSize: 11,
                ),
              ),
            const SizedBox(height: 7),
          ],
        ),
        const Expanded(child: SizedBox()),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildAboutUs() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: logic.onTapAboutUs,
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "关于我们",
              style: TextStyle(
                color: DunColors.gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "建议反馈 BUG提交 吹水扯淡",
              style: TextStyle(
                color: DunColors.graySubtitle,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowOnBilibili() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: logic.onTapFollowOnBilibili,
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "关注b站账号",
              style: TextStyle(
                color: DunColors.gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "欢迎关注我们",
              style: TextStyle(
                color: DunColors.graySubtitle,
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
      onTap: logic.onTapCheckUpgrade,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                const Text(
                  "检查更新",
                  style: TextStyle(
                    color: DunColors.gray_1,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Obx(() => Text(
                      state.version.value,
                      style: const TextStyle(
                        color: DunColors.graySubtitle,
                        fontSize: 11,
                      ),
                    )),
                const SizedBox(height: 7),
              ],
            ),
            const Spacer(),
            Obx(() => UpdateManager.getInstance().checking.value
                ? Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 20,
                    width: 20,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: DunColors.dunColor,
                    ),
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildDonation() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: logic.onTapDonation,
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7),
            Text(
              "支持我们",
              style: TextStyle(
                color: DunColors.gray_1,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "捐赠渠道",
              style: TextStyle(
                color: DunColors.graySubtitle,
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
      onTap: logic.onTapMobId,
      highlightColor: Colors.blue,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 7),
            Obx(() => Text(
                  state.mobRId.value,
                  style: const TextStyle(
                    color: DunColors.gray_1,
                    fontSize: 16,
                  ),
                )),
            const SizedBox(height: 2),
            const Text(
              "推送ID，收不到推送请点击复制ID联系我们，没有ID也联系我们",
              style: TextStyle(
                color: DunColors.graySubtitle,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }

  Widget _buildRecord() {
    return Column(
      children: [
        const Text(
          "Copyright: Ceobe Canteen",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        InkWell(
            onTap: logic.onTapRecord,
            child: Text(
              state.record,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ))
      ],
    );
  }
}
