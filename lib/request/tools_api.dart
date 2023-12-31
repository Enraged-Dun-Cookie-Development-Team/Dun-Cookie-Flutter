import 'package:dun_cookie_flutter/model/resource_info.dart';
import 'package:dun_cookie_flutter/model/video_model.dart';

import '../model/ceobecanteen_data.dart';
import 'main.dart';

/// 常用工具
class ToolsApi {
  /// 视频推荐

  static String videoRecommendUrl = "/canteen/operate/video/list";
  static Future<List<VideoModel>> getVideoList() async {
    ResponseData response = await HttpClass.get(videoRecommendUrl, type: 1);
    if (response.error) {
      return [];
    } else {
      return _responseDataToListData(response);
    }
  }

  static List<VideoModel> _responseDataToListData(ResponseData request) {
    List<VideoModel> resultAll = [];
    if (request.data is Map) {
      Map map = request.data;
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

  static String resourceInfoUrl = "/canteen/operate/resource/get";
  static Future<ResourceInfo?> getResourceInfo() async {
    ResponseData response = await HttpClass.get(resourceInfoUrl, type: 1);
    if (response.error) {
      return null;
    } else {
      return ResourceInfo.fromJson(response.data["data"]);
    }
  }

  ///友站链接
  static String toolLinkInfoUrl = "/canteen/operate/toolLink/list";
  static Future<List<QuickJump>> getToolLinkInfoUrl() async {
    ResponseData response = await HttpClass.get(toolLinkInfoUrl, type: 1);
    if (response.error) {
      return [];
    } else {
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

}
