import 'package:dun_cookie_flutter/model/resource_info.dart';
import 'package:dun_cookie_flutter/model/video_model.dart';

import '../../model/ceobecanteen_data.dart';
import '../request.dart';
import '../respond.dart';


/// 常用工具
class ToolsApi {
  /// 视频推荐
  static Future<List<VideoModel>> getVideoList() async {
    ResponseData response = await HttpClass.get(
        UrlString.videoRecommendUrl, type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToVideoListData(response);
    }
  }

  static List<VideoModel> _responseDataToVideoListData(ResponseData response) {
    List<VideoModel> resultAll = [];
    if (response.data is Map) {
      Map map = response.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(VideoModel.fromJson(model));
        }
      }
    }
    return resultAll;
  }

  /// 顶部资源信息
  static Future<ResourceInfo?> getResourceInfo() async {
    ResponseData response = await HttpClass.get(
        UrlString.resourceInfoUrl, type: RequestType.server);
    if (response.error) {
      return null;
    } else {
      return ResourceInfo.fromJson(response.data["data"]);
    }
  }

  ///友站链接
  static Future<List<QuickJump>> getToolLinkInfo() async {
    ResponseData response = await HttpClass.get(
        UrlString.toolLinkInfoUrl, type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToToolLinkInfoData(response);
    }
  }

  static List<QuickJump> _responseDataToToolLinkInfoData(ResponseData response) {
    List<QuickJump> resultAll = [];
    if (response.data is Map) {
      Map map = response.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(QuickJump.fromJson(model));
        }
      }
    }
    return resultAll;
  }

}
