import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/video_model.dart';
import 'package:dun_cookie_flutter/page/tool/tool_link.dart';
import 'package:dun_cookie_flutter/page/tool/tool_video.dart';
import 'package:dun_cookie_flutter/request/tools_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreListWidget extends StatefulWidget {
  MoreListWidget({Key? key}) : super(key: key);

  @override
  State<MoreListWidget> createState() => _MoreListWidgetState();
}

class _MoreListWidgetState extends State<MoreListWidget> {
  CeobecanteenData? ceobecanteenData;
  List<VideoModel> videoList = [];

  @override
  void initState() {
    super.initState();
    ToolsApi.getVideoList().then((value) => setState(() => videoList = value));
  }

  @override
  Widget build(BuildContext context) {
    ceobecanteenData = Provider.of<CeobecanteenData>(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 150),
      children: [
        _buildTitle(),
        _buildOfficialManga(),
        _buildHoneyCakeWorkshop(),
        _buildToolLinks(),
        _buildVideoRecommend(),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "没有更多了",
              style: TextStyle(color: gray_1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14 - 7, 0),
      child: SizedBox(
        height: 42,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 7),
              padding: const EdgeInsets.fromLTRB(12, 11, 0, 11),
              color: gray_1,
              child: const Text(
                "常用工具&推荐",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                width: 17,
                height: 10,
                color: gray_2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficialManga() {
    String columnText = "官方漫画";
    List<Widget> titleTextList = [];
    for (int i = 0; i < columnText.length; i++) {
      titleTextList.add(Text(columnText[i], style: const TextStyle(color: white, fontSize: 11)));
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      height: 140,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: white,
      ),
      child: Stack(
        children: [
          Container(
            width: 20,
            color: gray_1,
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: titleTextList)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 6, 0, 0),
            width: 13,
            height: 8,
            color: blue,
          ),
        ],
      ),
    );
  }

  Widget _buildHoneyCakeWorkshop() {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      height: 90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: white,
      ),
      child: Column(
        children: [
          Container(
            height: 21,
            padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
            color: gray_1,
            child: Row(
              children: [
                const Text(
                  "第三方工具 · 罗德岛密饼工坊",
                  style: TextStyle(
                    fontSize: 12,
                    color: white,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  width: 10,
                  height: 10,
                  color: yellow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolLinks() {
    List<QuickJump>? dataList = ceobecanteenData?.quickJump;
    if (dataList == null || dataList.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 3,
        ),
        itemBuilder: (ctx, index) {
          return Card(child: ToolLink(dataList[index]));
        },
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildVideoRecommend() {
    if (videoList.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Column(
        children: [
          Container(
            height: 21,
            padding: const EdgeInsets.fromLTRB(10, 2, 8, 2),
            color: gray_1,
            child: Row(
              children: [
                const Text(
                  "视频推荐",
                  style: TextStyle(
                    fontSize: 12,
                    color: white,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  width: 10,
                  height: 10,
                  color: yellow,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: videoList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (ctx, index) {
              return Card(child: ToolVideo(videoList[index]));
            },
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
