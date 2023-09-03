/// "title": "罗德岛相簿",
/// "sub_title": "留下罗德岛干员生活的每一个瞬间！",
/// "cover_url": "https://web.hycdn.cn/comic/pic/20230620/11edecfb3f38018f16a55ddbb39a6814.png",
/// "episode_short_title": "75",
/// "updated_time": 1687363200000
/// 泰拉记事社漫画最新小漫画
class TerraRecentEpisodeModel {
  TerraRecentEpisodeModel({
      this.title, 
      this.subTitle, 
      this.coverUrl, 
      this.episodeShortTitle, 
      this.updatedTime
  });

  TerraRecentEpisodeModel.fromJson(dynamic json) {
    title = json['title'];
    subTitle = json['sub_title'];
    coverUrl = json['cover_url'];
    episodeShortTitle = json['episode_short_title'];
    updatedTime = json['updated_time'];
  }
  String? title;
  String? subTitle;
  String? coverUrl;
  String? episodeShortTitle;
  int? updatedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['sub_title'] = subTitle;
    map['cover_url'] = coverUrl;
    map['episode_short_title'] = episodeShortTitle;
    map['updated_time'] = updatedTime;
    return map;
  }
}