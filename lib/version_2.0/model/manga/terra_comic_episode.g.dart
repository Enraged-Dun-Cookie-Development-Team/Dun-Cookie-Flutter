// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terra_comic_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerraComicEpisodeModel _$TerraComicEpisodeModelFromJson(
        Map<String, dynamic> json) =>
    TerraComicEpisodeModel(
      comic: json['comic'] as String? ?? "",
      jumpUrl: json['jumpUrl'] as String? ?? "",
      shortTitle: json['shortTitle'] as String? ?? "",
    );

Map<String, dynamic> _$TerraComicEpisodeModelToJson(
        TerraComicEpisodeModel instance) =>
    <String, dynamic>{
      'comic': instance.comic,
      'jumpUrl': instance.jumpUrl,
      'shortTitle': instance.shortTitle,
    };
