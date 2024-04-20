import '../../model/config_datasource_model.dart';
import '../request.dart';
import '../respond.dart';

class BaseConfigRequest {
  /// 全部数据源列表
  static Future<List<ConfigDatasourceModel>> getConfigDatasource() async {
    ResponseData response = await HttpClass.get(UrlString.configDatasourceUrl, type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToConfigDatasourceListData(response);
    }
  }
  static List<ConfigDatasourceModel> _responseDataToConfigDatasourceListData(
      ResponseData request) {
    List<ConfigDatasourceModel> resultAll = [];
    if (request.data is Map) {
      Map map = request.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(ConfigDatasourceModel.fromJson(model));
        }
      }
    }
    return resultAll;
  }

  ///更新数据源
  static Future<bool> updateDataSource(List<String> list) async {
    ResponseData response = await HttpClass.post(UrlString.updateDataSourceUrl,
        data: {
          "datasource_push": list,
        },
        type: RequestType.server);
    return response.isSuccess;
  }

}
