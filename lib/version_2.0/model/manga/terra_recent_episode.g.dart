// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terra_recent_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerraRecentEpisodeModel _$TerraRecentEpisodeModelFromJson(
        Map<String, dynamic> json) =>
    TerraRecentEpisodeModel(
      title: json['title'] as String? ?? "",
      subTitle: json['subTitle'] as String? ?? "",
      coverUrl: json['coverUrl'] as String?,
      episodeShortTitle: json['episodeShortTitle'] as String? ?? "",
      updatedTime: json['updatedTime'] as int? ?? 0,
    );

Map<String, dynamic> _$TerraRecentEpisodeModelToJson(
        TerraRecentEpisodeModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'coverUrl': instance.coverUrl,
      'episodeShortTitle': instance.episodeShortTitle,
      'updatedTime': instance.updatedTime,
    };
