/// start_time : "2021-12-24 04:00:00"
/// over_time : "2022-01-04 15:59:59"
/// title : "2022明日方舟新春会「流光启明」庆 典宣传PV"
/// author : "杨颜同学"
/// video_link : "https://www.bilibili.com/video/bv19b4y1v7Wa"
/// cover_img : "http://i0.hdslb.com/bfs/archive/9315a9911f8af1441854a16c93339926b9c66a8b.jpg@@200w_125h_1c.webp"

class VideoModel {
  VideoModel({
      String? startTime, 
      String? overTime, 
      String? title, 
      String? author, 
      String? videoLink, 
      String? coverImg,}){
    _startTime = startTime;
    _overTime = overTime;
    _title = title;
    _author = author;
    _videoLink = videoLink;
    _coverImg = coverImg;
}

  VideoModel.fromJson(dynamic json) {
    _startTime = json['start_time'];
    _overTime = json['over_time'];
    _title = json['title'];
    _author = json['author'];
    _videoLink = json['video_link'];
    _coverImg = json['cover_img'];
  }
  String? _startTime;
  String? _overTime;
  String? _title;
  String? _author;
  String? _videoLink;
  String? _coverImg;
VideoModel copyWith({  String? startTime,
  String? overTime,
  String? title,
  String? author,
  String? videoLink,
  String? coverImg,
}) => VideoModel(  startTime: startTime ?? _startTime,
  overTime: overTime ?? _overTime,
  title: title ?? _title,
  author: author ?? _author,
  videoLink: videoLink ?? _videoLink,
  coverImg: coverImg ?? _coverImg,
);
  String? get startTime => _startTime;
  String? get overTime => _overTime;
  String? get title => _title;
  String? get author => _author;
  String? get videoLink => _videoLink;
  String? get coverImg => _coverImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_time'] = _startTime;
    map['over_time'] = _overTime;
    map['title'] = _title;
    map['author'] = _author;
    map['video_link'] = _videoLink;
    map['cover_img'] = _coverImg;
    return map;
  }

}