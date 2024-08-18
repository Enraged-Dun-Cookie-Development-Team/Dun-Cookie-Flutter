import '../../model/ceobe/resource/resource_info.dart';
import '../../model/ceobe/tool/tool.dart';
import '../../model/ceobe/version/dun_app.dart';
import '../../model/ceobe/video/video.dart';
import '../request.dart';
import '../respond.dart';

/// 小刻食堂运营相关
/// 不允许出现脏数据，一旦解析错误，该数据将被移除
class CeobeApi {
  /// APP版本
  static Future<DunAppInfoModel?> getAppVersionInfo({String? version}) async {
    Map<String, dynamic> params = {};
    if (version != null) {
      params["version"] = version;
    }
    ResponseData response = await HttpClass.get(UrlString.appVersionUrl,
        params: params, type: RequestType.server);
    return response.toModel(
      transform: (json) => DunAppInfoModel.fromJson(json),
      onError: () => null,
    );
  }

  /// 视频推荐
  static Future<List<VideoModel>> getVideoInfo() async {
    ResponseData response = await HttpClass.get(UrlString.videoRecommendUrl,
        type: RequestType.server);
    return response.toModelList(
      transform: (json) => VideoModel.fromJson(json),
      onError: () => [],
    );
  }

  /// 顶部资源信息
  static Future<ResourceInfoModel> getResourceInfo() async {
    ResponseData response = await HttpClass.get(UrlString.resourceInfoUrl,
        type: RequestType.server);
    return response.toModel(
      transform: (json) => ResourceInfoModel.fromJson(json),
      onError: () => ResourceInfoModel.fromJson({}),
    );
  }

  ///友站链接
  static Future<List<ToolModel>> getQuickJumpInfo() async {
    ResponseData response = await HttpClass.get(UrlString.toolLinkInfoUrl,
        type: RequestType.server);
    return response.toModelList(
      transform: (json) => ToolModel.fromJson(json),
      onError: () => [],
    );
  }
}
