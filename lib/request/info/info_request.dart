import '../../model/info/user_settings.dart';
import '../api.dart';
import '../request.dart';
import '../respond.dart';

class InfoRequest {
  /// 创建新用户
  static Future<bool> createUser(String? mobId) async {
    ResponseData response = await HttpClass.post(UrlString.createUserUrl,
        data: {"mob_id": mobId},
        type: RequestType.server,
        fromJson: (Map<String, dynamic> data) {});
    String code = response.code;
    return !response.error || code == USER_HAS_CREATE;
  }

  /// 根据mobId获取用户数据源配置
  static Future<ResponseData<UserDatasourceModel>>
      getUserDatasourceSettings() async {
    ResponseData<UserDatasourceModel> response = await HttpClass.get(
        UrlString.userDatasourceSettingsUrl,
        type: RequestType.server,
        fromJson: UserDatasourceModel.fromJson);
    return response;
  }

  ///更新数据源
  static Future<ResponseData> updateDataSource(Set<String> list) async {
    ResponseData response = await HttpClass.post(UrlString.updateDataSourceUrl,
        data: {
          "datasource_push": list.toList(),
        },
        type: RequestType.server,
        fromJson: (_) {});
    return response;
  }
}
