import '../../model/config/config_datasource.dart';
import '../request.dart';
import '../respond.dart';

class ConfigRequest {
  /// 全部数据源列表
  static Future<List<ConfigDatasourceModel>> getConfigDatasource() async {
    ResponseData response = await HttpClass.get(UrlString.configDatasourceUrl,
        type: RequestType.server);
    return response.toModelList(
      transform: (json) => ConfigDatasourceModel.fromJson(json),
      onError: () => [],
    );
  }
}
