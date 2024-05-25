import '../../model/config/config_datasource.dart';
import '../request.dart';
import '../respond.dart';

class ConfigRequest {
  /// 全部数据源列表
  static Future<List<ConfigDatasourceModel>> getConfigDatasource() async {
    ResponseData response = await HttpClass.get(UrlString.configDatasourceUrl,
        type: RequestType.server);
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
}
