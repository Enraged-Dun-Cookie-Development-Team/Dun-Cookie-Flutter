// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terra_recent_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerraRecentEpisodeModel _$TerraRecentEpisodeModelFromJson(
        Map<String, dynamic> json) =>
    TerraRecentEpisodeModel(
      title: json['title'] as String? ?? '',
      subTitle: json['sub_title'] as String? ?? '',
      coverUrl: json['cover_url'] as String?,
      episodeShortTitle: json['episode_short_title'] as String? ?? '',
      updatedTime: (json['updated_time'] as num?)?.toInt() ?? 0,
    );
