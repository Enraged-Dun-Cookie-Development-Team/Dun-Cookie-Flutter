// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terra_comic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerraComicModel _$TerraComicModelFromJson(Map<String, dynamic> json) =>
    TerraComicModel(
      comic: json['comic'] as String? ?? "",
      updateTime: json['updateTime'] as int? ?? 0,
      count: json['count'] as int? ?? 0,
      cover: json['cover'] as String? ?? "",
      introduction: json['introduction'] as String? ?? "",
      authors:
          (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      subtitle: json['subtitle'] as String? ?? "",
      title: json['title'] as String? ?? "",
    );

Map<String, dynamic> _$TerraComicModelToJson(TerraComicModel instance) =>
    <String, dynamic>{
      'comic': instance.comic,
      'updateTime': instance.updateTime,
      'count': instance.count,
      'cover': instance.cover,
      'introduction': instance.introduction,
      'authors': instance.authors,
      'keywords': instance.keywords,
      'subtitle': instance.subtitle,
      'title': instance.title,
    };
