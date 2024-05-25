// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      startTime: json['startTime'] as String,
      overTime: json['overTime'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      videoLink: json['videoLink'] as String,
      coverImg: json['coverImg'] as String,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'overTime': instance.overTime,
      'title': instance.title,
      'author': instance.author,
      'videoLink': instance.videoLink,
      'coverImg': instance.coverImg,
    };
