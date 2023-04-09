import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/component/single_round_title.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/container_with_label.dart';
import 'package:flutter/material.dart';

class MoreListWidget extends StatelessWidget {
  const MoreListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      children: [
        const ContainerWithLabel(containerWidth: 110, text: "第三方工具", labelColor: gray_2),
        _buildHoneyCakeWorkshop(),
        _buildOfficialCartoon(),
        _buildTerraWeeklyNews(),
      ],
    );
  }

  // 蜜饼工坊
  Widget _buildHoneyCakeWorkshop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SingleRoundTitle("蜜饼工坊"),
        const SizedBox(height: 12),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white,
          ),
          height: 80,
        ),
      ],
    );
  }

  // 官方漫画
  Widget _buildOfficialCartoon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SingleRoundTitle("官方漫画"),
        const SizedBox(height: 12),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white,
          ),
          height: 80,
        ),
      ],
    );
  }

  // 泰拉每周速递
  Widget _buildTerraWeeklyNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SingleRoundTitle("泰拉每周速递"),
        const SizedBox(height: 12),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white,
          ),
          height: 80,
        ),
      ],
    );
  }
}
