import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class VideoModel {
  final String startTime;
  final String overTime;
  final String title;
  final String author;
  final String videoLink;
  final String coverImg;

  VideoModel({
    required this.startTime,
    required this.overTime,
    required this.title,
    required this.author,
    required this.videoLink,
    required this.coverImg,
  });

  factory VideoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
