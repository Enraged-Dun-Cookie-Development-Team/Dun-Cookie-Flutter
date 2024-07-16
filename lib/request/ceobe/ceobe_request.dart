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
    if (response.data != null) {
      try {
        return DunAppInfoModel.fromJson(response.data?["data"]);
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
  }

  /// 视频推荐
  static Future<List<VideoModel>> getVideoInfo() async {
    ResponseData response = await HttpClass.get(UrlString.videoRecommendUrl,
        type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToVideoInfoData(response);
    }
  }

  static List<VideoModel> _responseDataToVideoInfoData(ResponseData response) {
    List<VideoModel> resultAll = [];
    if (response.data is Map) {
      Map map = response.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          try {
            resultAll.add(VideoModel.fromJson(model));
          } catch (e) {
            print(e);
            continue;
          }
        }
      }
    }
    return resultAll;
  }

  /// 顶部资源信息
  static Future<ResourceInfoModel> getResourceInfo() async {
    ResponseData response = await HttpClass.get(UrlString.resourceInfoUrl,
        type: RequestType.server);
    if (response.error) {
      return ResourceInfoModel.fromJson({});
    } else {
      try {
        return ResourceInfoModel.fromJson(response.data["data"]);
      } catch (e) {
        print(e);
        return ResourceInfoModel.fromJson({});
      }
    }
  }

  ///友站链接
  static Future<List<ToolModel>> getQuickJumpInfo() async {
    ResponseData response = await HttpClass.get(UrlString.toolLinkInfoUrl,
        type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToQuickJumpData(response);
    }
  }

  static List<ToolModel> _responseDataToQuickJumpData(ResponseData response) {
    List<ToolModel> resultAll = [];
    if (response.data is Map) {
      Map map = response.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          try {
            resultAll.add(ToolModel.fromJson(model));
          } catch (e) {
            print(e);
            continue;
          }
        }
      }
    }
    return resultAll;
  }
}
