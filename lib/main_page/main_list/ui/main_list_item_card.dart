import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/main_page/common_ui/dashed_line_widget.dart';
import 'package:dun_cookie_flutter/main_page/main_list/ui/images_widget.dart';
import 'package:dun_cookie_flutter/model/setting_data.dart';
import 'package:dun_cookie_flutter/model/source_data.dart';
import 'package:flutter/material.dart';

class MainListItemCard extends StatelessWidget {
  final SourceData? data;
  final SettingData? settingData;
  const MainListItemCard({required this.data, required this.settingData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      color: white,
      child: Stack(
        children: [
          ..._buildBg(),
          _buildIcon(),
          _buildTitle(),
          _buildTime(),
          _buildContent(),
        ],
      ),
    );
  }

  List<Widget> _buildBg() {
    return [
      /// 左上灰色label
      Container(
        width: 14,
        height: 60,
        color: gray_1,
      ),

      /// 右上黄色label
      Positioned(
        top: 51,
        right: 18,
        child: Container(
          width: 13,
          height: 19,
          color: yellow,
        ),
      ),

      /// 虚线
      const Positioned(
        left: 26,
        top: 60,
        right: 40,
        child: DashedLineWidget(),
      )
    ];
  }

  Widget _buildIcon() {
    return Positioned(
      left: 26,
      top: 11,
      child: Image.asset(
        data?.sourceInfo?.icon ?? 'assets/icon/main_list_icon.png',
        width: 38,
        height: 38,
        fit: BoxFit.cover,
        alignment: Alignment.topLeft,
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 70,
      top: 11,
      child: Text(
        data?.sourceInfo?.title ?? '',
        style: const TextStyle(
          fontSize: 15,
          color: yellow,
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Positioned(
      left: 70,
      top: 32,
      child: Text(
        data?.timeForDisplay ?? '',
        style: const TextStyle(
          fontSize: 13,
          color: gray_2,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 73, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.content ?? '',
            style: const TextStyle(
              color: gray_2,
              fontSize: 11,
            ),
          ),
          ImageWidget(
            data: data,
            settingData: settingData,
          ),
        ],
      ),
    );
  }
}
