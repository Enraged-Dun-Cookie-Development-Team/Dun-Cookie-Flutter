import '../../model/info/user_settings.dart';
import '../request.dart';
import '../respond.dart';

class InfoRequest {
  /// 创建新用户
  static Future<bool> createUser(String? mobId) async {
    ResponseData response = await HttpClass.post(UrlString.createUserUrl,
        data: {"mob_id": mobId}, type: RequestType.server);
    String code = response.data.data["code"];
    return response.isSuccess || code == "C0018";
  }

  /// 根据mobId获取用户数据源配置
  static Future<UserDatasourceModel> getUserDatasourceSettings() async {
    ResponseData response = await HttpClass.get(
        UrlString.userDatasourceSettingsUrl,
        type: RequestType.server);
    if (response.data != null) {
      return UserDatasourceModel.fromJson(response.data?["data"]);
    }
    return UserDatasourceModel.fromJson({});
  }

  ///更新数据源
  static Future<bool> updateDataSource(Set<String> list) async {
    ResponseData response = await HttpClass.post(UrlString.updateDataSourceUrl,
        data: {
          "datasource_push": list.toList(),
        },
        type: RequestType.server);
    return response.isSuccess;
  }
}
