import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../widget/cookie/container_with_label.dart';
import '../../widget/cookie/cookie_card.dart';
import 'logic.dart';

class CookiesPage extends StatefulWidget {
  const CookiesPage({super.key});

  @override
  State<CookiesPage> createState() => _CookiesPageState();
}

class _CookiesPageState extends State<CookiesPage> {
  final logic = Get.put(CookiesLogic());
  final state = Get.find<CookiesLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Column(
        children: [
          _buildTitleBar(),
          _buildList(),
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
                    height: 42,
                    color: DunColors.white,
                    padding: REdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: state.searchController,
                      focusNode: state.searchFocusNode,
                      cursorColor: DunColors.dunColor,
                      decoration: const InputDecoration(
                        isDense: true,
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
                      padding: REdgeInsets.all(10),
                      child: Image.asset(
                        "assets/icon/search.png",
                        color: DunColors.yellow,
                        isAntiAlias: true,
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
        color: DunColors.dunColor,
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
    return Obx(() {
      var cookies =
          state.searchStatue.value ? state.searchCookieList : state.cookieList;
      var nextPageId = state.searchStatue.value
          ? state.searchNextPageId.value
          : state.nextPageId.value;
      if (cookies.isNotEmpty) {
        return ListView.builder(
          key: const PageStorageKey<String>("cookieList"),
          controller: state.scrollController,
          padding: REdgeInsets.only(bottom: 20.r),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index == cookies.length) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    nextPageId.isEmpty ? "已经没有饼了，小刻很满足！！！" : "精美的加载动画",
                    style: const TextStyle(color: DunColors.gray_1),
                  ),
                ),
              );
            } else {
              return CookieCard(
                data: cookies[index],
                onTapCard: logic.onTapCard,
                onTapShare: logic.onTapShare,
                onTapImage: logic.onTapImage,
              );
            }
          },
          itemCount: cookies.length + 1,
        );
      } else {
        return Center(
          child: Image.asset("assets/image/load/loading.gif", height: 150),
        );
      }
    });
  }
}
