import 'package:json_annotation/json_annotation.dart';

part 'terra_comic_episode.g.dart';

@JsonSerializable(createToJson: false)
class TerraComicEpisodeModel {
  TerraComicEpisodeModel({
    required this.episodeId,
    required this.comic,
    required this.jumpUrl,
    required this.shortTitle,
  });

  @JsonKey(name: 'episode_id', defaultValue: '')
  String episodeId;
  @JsonKey(defaultValue: '')
  String comic;
  @JsonKey(name: 'jump_url', defaultValue: '')
  String jumpUrl;
  @JsonKey(name: 'short_title', defaultValue: '')
  String shortTitle;

  factory TerraComicEpisodeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TerraComicEpisodeModelFromJson(srcJson);
}
