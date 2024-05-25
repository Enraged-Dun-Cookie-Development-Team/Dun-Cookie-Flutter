import 'package:json_annotation/json_annotation.dart';

part 'terra_comic_episode.g.dart';

@JsonSerializable()
class TerraComicEpisodeModel {
  TerraComicEpisodeModel({
    this.comic = "",
    this.jumpUrl = "",
    this.shortTitle = "",
  });

  String comic;
  String jumpUrl;
  String shortTitle;

  factory TerraComicEpisodeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TerraComicEpisodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TerraComicEpisodeModelToJson(this);
}
