import '../../model/ceobe/resource/resource_info.dart';
import '../../model/ceobe/tool/tool.dart';
import '../../model/ceobe/version/dun_app.dart';
import '../../model/ceobe/video/video.dart';
import '../api.dart';
import '../request.dart';
import '../respond.dart';

/// 小刻食堂运营相关
/// 不允许出现脏数据，一旦解析错误，该数据将被移除
class CeobeApi {
  /// APP版本
  static Future<ResponseData<DunAppInfoModel>> getAppVersionInfo(
      {String? version}) async {
    Map<String, dynamic> params = {'platform': 'pocket'};
    if (version != null) {
      params["version"] = version;
    }
    ResponseData<DunAppInfoModel> response =
        await HttpClass.get<DunAppInfoModel>(UrlString.appVersionUrl,
            params: params,
            type: RequestType.serveCdn,
            fromJson: DunAppInfoModel.fromJson);
    return response;
  }

  /// 视频推荐
  static Future<ResponseData<List<VideoModel>>> getVideoInfo() async {
    ResponseData<List<VideoModel>> response =
        await HttpClass.get<List<VideoModel>>(UrlString.videoRecommendUrl,
            type: RequestType.server,
            fromJson: getListHandle(fromJson: VideoModel.fromJson));
    return response;
  }

  /// 顶部资源信息
  static Future<ResponseData<ResourceInfoModel>> getResourceInfo() async {
    ResponseData<ResourceInfoModel> response =
        await HttpClass.get<ResourceInfoModel>(UrlString.resourceInfoUrl,
            type: RequestType.server, fromJson: ResourceInfoModel.fromJson);
    return response;
  }

  ///友站链接
  static Future<ResponseData<List<ToolModel>>> getQuickJumpInfo() async {
    ResponseData<List<ToolModel>> response =
        await HttpClass.get<List<ToolModel>>(UrlString.toolLinkInfoUrl,
            type: RequestType.server,
            fromJson: getListHandle(fromJson: ToolModel.fromJson));
    return response;
  }
}
