import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../model/bakery/bakery_data.dart';
import '../../request/bakery/bakery_request.dart';
import 'state.dart';

class HoneyCakeWorkshopLogic extends GetxController {
  final HoneyCakeWorkshopState state = HoneyCakeWorkshopState();

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  Future<void> refreshData() async {
    await getBakeryMansionIdList();
    if (state.bakeryMansionIdList.isNotEmpty) {
      await getBakeryInfo(state.bakeryMansionIdList.last);
    }
  }

  void onTapBack() {
    Get.back();
  }

  Future<void> getBakeryMansionIdList() async {
    var responseData = await BakeryApi.getBakeryMansionIdList();
    if (!responseData.error) {
      List<String>? data = responseData.data;
      if (data != null) {
        state.bakeryMansionIdList.value = data;
      }
    }
  }

  Future<void> getBakeryInfo(String? id) async {
    if (id != null) {
      var responseData = await BakeryApi.getBakeryInfo(id);
      if (!responseData.error) {
        BakeryDataModel? data = responseData.data;
        if (data != null) {
          state.bakeryData.value = data;
        }
      }
    }
  }

  void onTapBottomButton() {
    DunJump.openAppOrWebPage(
      url: "https://m.bilibili.com/space/8412516",
      appUrlScheme: "bilibili://space/8412516",
    );
  }
}
