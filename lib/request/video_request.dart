import 'package:dun_cookie_flutter/model/video_model.dart';

import 'main.dart';

class VideoRequest {
  
  static _getVideoList() async {
    const url ="/canteen/operate/video/list";
    print("获取视频信息数据");
    return await HttpClass.get(url, type: 1);
  }

  //  处理返回的数据
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
  
  static Future<List<VideoModel>> getVideoList() async {
    ResponseData response = await _getVideoList();
    if (response.error) {
      return [];
    } else {
      return _responseDataToListData(response);
    }
  }
}