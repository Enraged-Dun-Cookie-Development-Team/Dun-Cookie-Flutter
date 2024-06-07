
import 'package:get/get.dart';

import '../../common/dun_jump.dart';
import '../../model/manga/terra_comic_episode.dart';
import '../../request/manga/manga_request.dart';
import 'state.dart';

class MangaLogic extends GetxController {
  final MangaState state = MangaState();

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  //  获取数据
  loadData() async {
    state.loadDataType.value = 1;
    state.comicsList = await MangaApi.getTerraComicList();
    if (state.comicsList.isNotEmpty) {
      state.loadDataType.value = 0;
    } else {
      state.loadDataType.value = 2;
    }
  }

  void onTapBack() {
    Get.back();
  }

  void onTapManga(TerraComicEpisodeModel model) {
    DunJump.openWebPage(model.jumpUrl);
  }
}
