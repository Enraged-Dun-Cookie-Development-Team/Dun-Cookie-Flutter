import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../manager/setting_manager.dart';
import '../../widget/lazy_indexed_stack.dart';
import '../../widget/scroll_hide.dart';
import 'logic.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  final logic = Get.put(RootLogic());
  final state = Get.find<RootLogic>().state;

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: Container(
          color: DunColors.gray_3,
          padding: EdgeInsets.only(top: paddingTop),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder(
      init: logic,
      builder: (_) => Stack(
        children: [
          LazyIndexedStack(
            index: state.currentPageIndex,
            children: state.pageList,
          ),
          ScrollHideWidget(
            controller: state.scrollHideController,
            child: _buildBottomBar(context),
            builder: (context, child, isHidden) => AnimatedPositioned(
              bottom:
                  SettingManager.getInstance().isHideBottomOnScroll && isHidden
                      ? -(MediaQuery.of(context).padding.bottom + 100)
                      : 0,
              duration: Durations.medium2,
              curve: Curves.easeInOutSine,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60 + paddingBottom,
            decoration: _buildBottomShadow(),
            child: Row(
              children: [
                _buildBottomItem(
                  index: 1,
                  iconPath: 'assets/icon/more_list_icon.png',
                ),
                const Spacer(),
                _buildBottomItem(
                  index: 2,
                  iconPath: 'assets/icon/terminal_page_icon.png',
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: paddingBottom),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildMainBottomIcon(),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _buildBottomShadow() {
    return const BoxDecoration(
      color: DunColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          offset: Offset(0.0, 0.0),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        )
      ],
    );
  }

  Widget _buildBottomItem({
    required int index,
    required String iconPath,
  }) {
    final isSelected = state.currentPageIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => logic.onTapBottomItem(index),
        child: Image.asset(
          iconPath,
          width: 30,
          height: 30,
          color: isSelected ? DunColors.yellow : DunColors.gray_2,
          isAntiAlias: true,
        ),
      ),
    );
  }

  Widget _buildMainBottomIcon() {
    final isSelected = state.currentPageIndex == 0;
    return GestureDetector(
      onTap: () => logic.onTapBottomItem(0),
      child: Container(
        width: 83,
        height: 83,
        margin: REdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isSelected ? DunColors.yellow : DunColors.gray_2,
            width: 2,
          ),
          color: isSelected ? DunColors.yellow : DunColors.white,
        ),
        child: Center(
          child: Image.asset(
            'assets/icon/main_list_icon.png',
            width: 57,
            height: 48,
            color: isSelected ? DunColors.white : DunColors.gray_2,
            isAntiAlias: true,
          ),
        ),
      ),
    );
  }
}
