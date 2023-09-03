/// "comic": "6253",
/// "update_time": 1686931200000,
/// "count": 1,
/// "cover": "https://web.hycdn.cn/comic/pic/20230202/db410055280ccdf3ef46f90421e503e8.jpg",
/// "introduction": "与阿米娅和博士一起走近罗德岛干员。",
/// "authors": ["鹰角网络"],
/// "keywords": ["搞笑","轻松"],
/// "subtitle": "你可能不知道的罗德岛小剧场！",
/// "title": "123罗德岛！？"
/// 泰拉记事社漫画信息
class TerraComicModel {
  TerraComicModel({
      this.comic,
      this.updateTime, 
      this.count, 
      this.cover, 
      this.introduction, 
      this.authors, 
      this.keywords, 
      this.subtitle, 
      this.title,
  });

  TerraComicModel.fromJson(dynamic json) {
    comic = json['comic'];
    updateTime = json['update_time'];
    count = json['count'];
    cover = json['cover'];
    introduction = json['introduction'];
    authors = json['authors'] != null ? json['authors'].cast<String>() : [];
    keywords = json['keywords'] != null ? json['keywords'].cast<String>() : [];
    subtitle = json['subtitle'];
    title = json['title'];
  }
  String? comic;
  int? updateTime;
  int? count;
  String? cover;
  String? introduction;
  List<String>? authors;
  List<String>? keywords;
  String? subtitle;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comic'] = comic;
    map['update_time'] = updateTime;
    map['count'] = count;
    map['cover'] = cover;
    map['introduction'] = introduction;
    map['authors'] = authors;
    map['keywords'] = keywords;
    map['subtitle'] = subtitle;
    map['title'] = title;
    return map;
  }

}