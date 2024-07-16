// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terra_comic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerraComicModel _$TerraComicModelFromJson(Map<String, dynamic> json) =>
    TerraComicModel(
      comic: json['comic'] as String? ?? '',
      updateTime: (json['update_time'] as num?)?.toInt() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      cover: json['cover'] as String? ?? '',
      introduction: json['introduction'] as String? ?? '',
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subtitle: json['subtitle'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );
