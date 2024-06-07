import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable(createToJson: false)
class VideoModel {
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'over_time')
  final String overTime;
  final String title;
  final String author;
  @JsonKey(name: 'video_link')
  final String url;
  @JsonKey(name: 'cover_img')
  final String coverImg;

  VideoModel({
    required this.startTime,
    required this.overTime,
    required this.title,
    required this.author,
    required this.url,
    required this.coverImg,
  });

  factory VideoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoModelFromJson(srcJson);
}
