import '../../model/bakery/bakery_data.dart';
import '../request.dart';
import '../respond.dart';

class BakeryApi {
  /// 请求测试饼组数据
  static Future<BakeryDataModel?> getTestBakeryInfo() async {
    //print("请求测试饼组数据");
    ResponseData response = await HttpClass.get(UrlString.testBakeryInfoUrl,
        type: RequestType.server);
    return response.toModel(
      transform: (json) => BakeryDataModel.fromJson(json),
      onError: () => null,
    );
  }

  /// 请求饼组ID列表
  static Future<List<String>> getBakeryMansionIdList() async {
    //print("请求饼组ID列表");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryMansionIdListUrl,
        type: RequestType.server);
    return response.toValueList<String>(
      onError: () => [],
    );
  }

  /// 根据ID请求饼组数据
  static Future<BakeryDataModel?> getBakeryInfo(id) async {
    //print("根据ID请求饼组数据");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryMansionInfoUrl(id),
        type: RequestType.server);
    return response.toModel(
      transform: (json) => BakeryDataModel.fromJson(json),
      onError: () => null,
    );
  }

  /// 获取蜜饼工坊最近一次预测信息
  static Future<BakeryRecentPredictModel> getBakeryRecentPredict() async {
    //print("获取蜜饼工坊最近一次预测信息");
    ResponseData response = await HttpClass.get(
        UrlString.bakeryRecentPredictUrl,
        type: RequestType.server);
    return response.toModel(
      transform: (json) => BakeryRecentPredictModel.fromJson(json),
      onError: () => BakeryRecentPredictModel.fromJson({}),
    );
  }
}
