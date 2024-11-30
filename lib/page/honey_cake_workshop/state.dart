import 'package:dun_cookie_flutter/model/bakery/bakery_data.dart';
import 'package:get/get.dart';

class HoneyCakeWorkshopState {
  int loadDataType = 0;

  RxList<String> bakeryMansionIdList = RxList.empty();

  Rx<BakeryDataModel> bakeryData = BakeryDataModel.fromJson({}).obs;

  HoneyCakeWorkshopState() {
    ///Initialize variables
  }
}
