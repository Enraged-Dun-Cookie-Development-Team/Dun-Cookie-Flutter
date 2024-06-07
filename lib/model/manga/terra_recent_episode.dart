import 'package:json_annotation/json_annotation.dart';

part 'terra_recent_episode.g.dart';

@JsonSerializable(createToJson: false)
class TerraRecentEpisodeModel {
  TerraRecentEpisodeModel(
      {required this.title,
      required this.subTitle,
      this.coverUrl,
      required this.episodeShortTitle,
      required this.updatedTime});

  @JsonKey(defaultValue: '')
  String title;
  @JsonKey(name: 'sub_title', defaultValue: '')
  String subTitle;
  @JsonKey(name: 'cover_url')
  String? coverUrl;
  @JsonKey(name: 'episode_short_title',defaultValue: '')
  String episodeShortTitle;
  @JsonKey(name: 'updated_time', defaultValue: 0)
  int updatedTime;

  factory TerraRecentEpisodeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TerraRecentEpisodeModelFromJson(srcJson);
}
