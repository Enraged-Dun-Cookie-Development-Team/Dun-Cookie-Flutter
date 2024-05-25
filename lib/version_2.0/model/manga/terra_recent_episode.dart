import 'package:json_annotation/json_annotation.dart';

part 'terra_recent_episode.g.dart';

@JsonSerializable()
class TerraRecentEpisodeModel {
  TerraRecentEpisodeModel(
      {this.title = "",
      this.subTitle = "",
      this.coverUrl,
      this.episodeShortTitle = "",
      this.updatedTime = 0});

  String title;
  String subTitle;
  String? coverUrl;
  String episodeShortTitle;
  int updatedTime;

  factory TerraRecentEpisodeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TerraRecentEpisodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TerraRecentEpisodeModelToJson(this);
}
