import '../../model/bakery/bakery_data.dart';
import '../api.dart';
import '../request.dart';
import '../respond.dart';

class BakeryApi {
  /// 请求测试饼组数据
  static Future<ResponseData<BakeryDataModel>> getTestBakeryInfo() async {
    //print("请求测试饼组数据");
    ResponseData<BakeryDataModel> response =
        await HttpClass.get<BakeryDataModel>(UrlString.testBakeryInfoUrl,
            type: RequestType.server, fromJson: BakeryDataModel.fromJson);
    return response;
  }

  /// 请求饼组ID列表
  static Future<ResponseData<List<String>>> getBakeryMansionIdList() async {
    //print("请求饼组ID列表");
    ResponseData<List<String>> response = await HttpClass.get<List<String>>(
      UrlString.bakeryMansionIdListUrl,
      type: RequestType.serveCdn,
      fromJson: getListHandle(fromJson: (jsonSrc) => jsonSrc.toString()),
    );
    return response;
  }

  /// 根据ID请求饼组数据
  static Future<ResponseData<BakeryDataModel>> getBakeryInfo(String id) async {
    //print("根据ID请求饼组数据");
    ResponseData<BakeryDataModel> response =
        await HttpClass.get<BakeryDataModel>(UrlString.bakeryMansionInfoUrl(id),
            type: RequestType.serveCdn, fromJson: BakeryDataModel.fromJson);
    return response;
  }

  /// 获取蜜饼工坊最近一次预测信息
  static Future<ResponseData<BakeryRecentPredictModel>>
      getBakeryRecentPredict() async {
    //print("获取蜜饼工坊最近一次预测信息");
    ResponseData<BakeryRecentPredictModel> response =
        await HttpClass.get<BakeryRecentPredictModel>(
            UrlString.bakeryRecentPredictUrl,
            type: RequestType.serveCdn,
            fromJson: BakeryRecentPredictModel.fromJson);
    return response;
  }
}
