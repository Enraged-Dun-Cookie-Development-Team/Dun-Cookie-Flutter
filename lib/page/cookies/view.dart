import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';

import '../../widget/cookie/container_with_label.dart';
import '../../widget/cookie/cookie_card.dart';
import 'logic.dart';



class CookiesPage extends StatelessWidget {
  CookiesPage({Key? key}) : super(key: key);

  final logic = Get.put(CookiesLogic());
  final state = Get.find<CookiesLogic>().state;

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

  Widget _buildTitleBar() {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          const ContainerWithLabel(
            text: "小刻食堂",
            containerWidth: 90,
            labelColor: DunColors.yellow,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 14,
                  color: DunColors.gray_1,
                ),
                Expanded(
                  child: Container(
                    color: DunColors.white,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: state.searchController,
                      focusNode: state.searchFocusNode,
                      cursorColor: DunColors.DunColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '搜索：皮肤',
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.search,
                      onTapOutside: (_) {
                        state.searchFocusNode.unfocus();
                      },
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
                          color: DunColors.white,
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
                  color: DunColors.white,
                ),
                Container(
                  width: 44,
                  height: 42,
                  color: DunColors.gray_1,
                  child: GestureDetector(
                    onTap: () => {logic.handleSearch()},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icon/search.png",
                        color: DunColors.yellow,
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

  Widget _buildList() {
    return Expanded(
      child: RefreshIndicator(
        color: DunColors.DunColor,
        onRefresh: logic.onRefresh,
        child: GetBuilder<CookiesLogic>(
          id: state.listGID,
          builder: (logic) {
            return cookieList();
          },
        ),
      ),
    );
  }

  Widget cookieList() {
    var cookies =
        state.searchStatue ? state.searchCookieList : state.cookieList;
    if (cookies.isNotEmpty) {
      return ListView.builder(
        key: const PageStorageKey<String>("cookieList"),
        controller: state.scrollController,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return index == cookies.length
              ? (state.nextPageId == null
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Text(
                          "已经没有饼了，小刻很满足！！！",
                          style: TextStyle(color: DunColors.gray_1),
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Text(
                          "精美的加载动画",
                          style: TextStyle(color: DunColors.gray_1),
                        ),
                      ),
                    ))
              : CookieCard(
                  data: cookies[index],
                  onTapCard: logic.onTapCard,
                  onTapShare: logic.onTapShare,
                  onTapImage: logic.onTapImage,
                );
        },
        itemCount: cookies.length + 1,
      );
    } else {
      return Center(
        child: Image.asset("assets/image/load/loading.gif", height: 150),
      );
    }
  }
}
