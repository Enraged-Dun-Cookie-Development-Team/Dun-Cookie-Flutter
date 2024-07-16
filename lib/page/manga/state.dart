import 'package:get/get.dart';

import '../../model/manga/terra_comic.dart';



class MangaState {
  List<TerraComicModel> comicsList = [];

  //  加载状态 0一切正常 1正在加载 2加载失败
  RxInt loadDataType = 0.obs;

  MangaState() {
    ///Initialize variables
  }
}
