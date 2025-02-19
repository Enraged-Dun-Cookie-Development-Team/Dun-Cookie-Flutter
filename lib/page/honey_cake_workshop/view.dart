import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/dun_color.dart';
import '../../widget/honey_cake_workshop/honey_cake_card.dart';
import 'logic.dart';

class HoneyCakeWorkshopPage extends StatelessWidget {
  HoneyCakeWorkshopPage({super.key});

  final logic = Get.put(HoneyCakeWorkshopLogic());
  final state = Get.find<HoneyCakeWorkshopLogic>().state;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Scaffold(
        backgroundColor: DunColors.gray_3,
        appBar: AppBar(
          //蜜饼工坊页面
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
          title: const Text("罗德岛蜜饼工坊"),
          actions: [
            Obx(
              () => Padding(
                padding: REdgeInsets.only(right: 8),
                child: state.bakeryMansionIdList.isNotEmpty
                    ? SizedBox(
                        width: 80,
                        // 下拉列表框选版本
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: DunColors.dunColor, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: DunColors.dunColor, width: 1.5)),
                          ),
                          value: state.bakeryMansionIdList.last,
                          // 选择回调
                          onChanged: (String? value) =>
                              logic.getBakeryInfo(value),
                          // 传入可选的数组
                          items: state.bakeryMansionIdList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (state.bakeryData.value.id.isNotEmpty) {
                    return FadeIn(
                        duration: const Duration(milliseconds: 1000),
                        child: HoneyCakeWorkshopCard((state.bakeryData.value)));
                  } else {
                    return const Center(
                      child: Image(
                        image:
                            AssetImage("assets/image/load/bakery_loading.gif"),
                        width: 200,
                      ),
                    );
                  }
                }),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return GestureDetector(
      onTap: logic.onTapBottomButton,
      child: Container(
        height: 40,
        margin: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: DunColors.dunColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                image: AssetImage("assets/image/bilibili_up_mbgf.webp"),
                height: 24,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "前往 罗德岛蜜饼工坊 的B站空间",
              style: TextStyle(
                color: DunColors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
