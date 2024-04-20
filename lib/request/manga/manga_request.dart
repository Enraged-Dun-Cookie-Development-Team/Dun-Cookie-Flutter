import '../../model/terra_comic_episode_model.dart';
import '../../model/terra_comic_model.dart';
import '../../model/terra_recent_episode_model.dart';
import '../request.dart';
import '../respond.dart';

class MangaApi{
  /// 泰拉记事社漫画列表

  static Future<List<TerraComicModel>> getTerraComicList() async {
    ResponseData response = await HttpClass.get(UrlString.terraComicListUrl, type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToTerraComicListData(response);
    }
  }
  static List<TerraComicModel> _responseDataToTerraComicListData(ResponseData request) {
    List<TerraComicModel> resultAll = [];
    if (request.data is Map) {
      Map map = request.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(TerraComicModel.fromJson(model));
        }
      }
    }
    return resultAll;
  }

  /// 泰拉记事社漫画小节列表
  static Future<List<TerraComicEpisodeModel>> getTerraComicEpisodeList(String comicId) async {
    ResponseData response = await HttpClass.get(UrlString.getTerraComicEpisodeUrl(comicId), type: RequestType.server);
    if (response.error) {
      return [];
    } else {
      return _responseDataToTerraComicEpisodeListData(response);
    }
  }
  static List<TerraComicEpisodeModel> _responseDataToTerraComicEpisodeListData(ResponseData request) {
    List<TerraComicEpisodeModel> resultAll = [];
    if (request.data is Map) {
      Map map = request.data;
      var data = map["data"];
      if (data is List) {
        for (var model in data) {
          resultAll.add(TerraComicEpisodeModel.fromJson(model));
        }
      }
    }
    return resultAll;
  }

  /// 泰拉记事社最近漫画章节
  static Future<TerraRecentEpisodeModel?> getTerraNewestEpisode() async {
    ResponseData response = await HttpClass.get(UrlString.terraNewestEpisodeUrl, type: RequestType.server);
    if (response.error) {
      return TerraRecentEpisodeModel();
    } else {
      if (response.data['data'] != null) {
        return TerraRecentEpisodeModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    }
  }
}