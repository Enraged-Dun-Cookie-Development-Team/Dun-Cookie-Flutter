import '../../model/config/config_datasource.dart';
import '../api.dart';
import '../request.dart';
import '../respond.dart';

class ConfigRequest {
  /// 全部数据源列表
  static Future<ResponseData<List<ConfigDatasourceModel>>>
      getConfigDatasource() async {
    ResponseData<List<ConfigDatasourceModel>> response =
        await HttpClass.get<List<ConfigDatasourceModel>>(
            UrlString.configDatasourceUrl,
            type: RequestType.server,
            fromJson: getListHandle(fromJson: ConfigDatasourceModel.fromJson));
    return response;
  }
}
