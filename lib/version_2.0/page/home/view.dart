import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/tool/color_theme.dart';
import '../../widget/home/container_with_label.dart';
import '../../widget/home/cookieCard.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          _buildTitleBar(),
          _buildList(),
          Container(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: RefreshIndicator(
        color: DunColors.DunColor,
        onRefresh: logic.onRefresh,
        child: GetBuilder<HomeLogic>(
          id: state.listGID,
          builder: (logic) {
            return cookieList();
          },
        ),
      ),
    );
  }

  Widget cookieList() {
    if (state.data.isNotEmpty) {
      return ListView.builder(
        controller: state.scrollController,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return index == state.data.length
              ? (state.nextPageId == null
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Text(
                          "已经没有饼了，小刻很满足！！！",
                          style: TextStyle(color: gray_1),
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Text(
                          "精美的加载动画",
                          style: TextStyle(color: gray_1),
                        ),
                      ),
                    ))
              : CookieCard(
                  data: state.data[index],
                  onTapCard: logic.onTapCard,
                  onTapShare: logic.onTapShare,
                );
        },
        itemCount: state.data.length + 1,
      );
    } else {
      return Center(
        child: Image.asset("assets/image/load/loading.gif", height: 150),
      );
    }
  }

  Widget _buildTitleBar() {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          const ContainerWithLabel(
            text: "小刻食堂",
            containerWidth: 90,
            labelColor: yellow,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 14,
                  color: gray_1,
                ),
                Expanded(
                  child: Container(
                    color: white,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: state.searchController,
                      cursorColor: DunColors.DunColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '搜索：皮肤',
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) {
                        logic.handleSearch();
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Offstage(
                    offstage: state.offstage.value,
                    child: GestureDetector(
                        onTap: () => {state.searchController.clear()},
                        child: Container(
                          color: white,
                          height: 42,
                          child: Image.asset(
                            "assets/icon/close.png",
                            width: 16,
                            height: 16,
                          ),
                        )),
                  ),
                ),
                Container(
                  width: 5,
                  color: white,
                ),
                Container(
                  width: 44,
                  height: 42,
                  color: gray_1,
                  child: GestureDetector(
                    onTap: () => {logic.handleSearch()},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icon/search.png",
                        color: yellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
