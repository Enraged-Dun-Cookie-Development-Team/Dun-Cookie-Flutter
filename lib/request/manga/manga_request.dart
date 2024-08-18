import '../../model/manga/terra_comic.dart';
import '../../model/manga/terra_comic_episode.dart';
import '../../model/manga/terra_recent_episode.dart';
import '../request.dart';
import '../respond.dart';

class MangaApi {
  /// 泰拉记事社漫画列表
  static Future<List<TerraComicModel>> getTerraComicList() async {
    ResponseData response = await HttpClass.get(UrlString.terraComicListUrl,
        type: RequestType.server);
    return response.toModelList(
      transform: (json) => TerraComicModel.fromJson(json),
      onError: () => [],
    );
  }

  /// 泰拉记事社漫画小节列表
  static Future<List<TerraComicEpisodeModel>> getTerraComicEpisodeList(
      String comicId) async {
    ResponseData response = await HttpClass.get(
        UrlString.terraComicEpisodeUrl(comicId),
        type: RequestType.server);
    return response.toModelList(
      transform: (json) => TerraComicEpisodeModel.fromJson(json),
      onError: () => [],
    );
  }

  /// 泰拉记事社最近漫画章节
  static Future<TerraRecentEpisodeModel> getTerraNewestEpisode() async {
    ResponseData response = await HttpClass.get(UrlString.terraNewestEpisodeUrl,
        type: RequestType.server);
    return response.toModel(
      transform: (json) => TerraRecentEpisodeModel.fromJson(json),
      onError: () => TerraRecentEpisodeModel.fromJson({}),
    );
  }
}
