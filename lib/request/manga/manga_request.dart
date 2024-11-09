import '../../model/manga/terra_comic.dart';
import '../../model/manga/terra_comic_episode.dart';
import '../../model/manga/terra_recent_episode.dart';
import '../api.dart';
import '../request.dart';
import '../respond.dart';

class MangaApi {
  /// 泰拉记事社漫画列表
  static Future<ResponseData<List<TerraComicModel>>> getTerraComicList() async {
    ResponseData<List<TerraComicModel>> response = await HttpClass.get(
        UrlString.terraComicListUrl,
        type: RequestType.server,
        fromJson: getListHandle(fromJson: TerraComicModel.fromJson));
    return response;
  }

  /// 泰拉记事社漫画小节列表
  static Future<ResponseData<List<TerraComicEpisodeModel>>>
      getTerraComicEpisodeList(String comicId) async {
    ResponseData<List<TerraComicEpisodeModel>> response = await HttpClass.get(
        UrlString.terraComicEpisodeUrl(comicId),
        type: RequestType.server,
        fromJson: getListHandle(fromJson: TerraComicEpisodeModel.fromJson));
    return response;
  }

  /// 泰拉记事社最近漫画章节
  static Future<ResponseData<TerraRecentEpisodeModel>>
      getTerraNewestEpisode() async {
    ResponseData<TerraRecentEpisodeModel> response = await HttpClass.get(
        UrlString.terraNewestEpisodeUrl,
        type: RequestType.server,
        fromJson: TerraRecentEpisodeModel.fromJson);
    return response;
  }
}
