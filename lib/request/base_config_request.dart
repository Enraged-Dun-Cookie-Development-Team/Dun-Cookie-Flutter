
import '../model/Config_datasource_model.dart';
import 'main.dart';

class BaseConfigRequest {
  /// 全部数据源列表
  static const String configDatasourceUrl = "/canteen/config/datasource/list";
  static Future<List<ConfigDatasourceModel>> getConfigDatasource() async {
    ResponseData response = await HttpClass.get(configDatasourceUrl, type: 1);
    if (response.error) {
      return [];
    } else {
      return _responseDataToConfigDatasourceListData(response);
    }
  }
  static List<ConfigDatasourceModel> _responseDataToConfigDatasourceListData(ResponseData request) {
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
}