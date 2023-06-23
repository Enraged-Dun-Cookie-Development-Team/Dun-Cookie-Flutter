/// "comic": "2864",
/// "jump_url": "https://terra-historicus.hypergryph.com/comic/2864/episode/8651",
/// "short_title": "03"
/// 泰拉记事社单个漫画多小节
class TerraComicEpisodeModel {
  TerraComicEpisodeModel({
      this.comic, 
      this.jumpUrl, 
      this.shortTitle,});

  TerraComicEpisodeModel.fromJson(dynamic json) {
    comic = json['comic'];
    jumpUrl = json['jump_url'];
    shortTitle = json['short_title'];
  }
  String? comic;
  String? jumpUrl;
  String? shortTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comic'] = comic;
    map['jump_url'] = jumpUrl;
    map['short_title'] = shortTitle;
    return map;
  }

}