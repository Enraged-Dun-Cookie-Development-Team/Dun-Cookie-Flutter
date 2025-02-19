import 'package:get/get.dart';

import '../../model/bakery/bakery_data.dart';

class HoneyCakeWorkshopState {
  int loadDataType = 0;

  RxList<String> bakeryMansionIdList = RxList.empty();

  Rx<BakeryDataModel> bakeryData = BakeryDataModel.fromJson({}).obs;

  HoneyCakeWorkshopState() {
    ///Initialize variables
  }
}
