// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CookieInfoCountModel _$CookieInfoCountModelFromJson(
        Map<String, dynamic> json) =>
    CookieInfoCountModel(
      totalCount: json['totalCount'] as int? ?? 0,
      skinCount: json['skinCount'] as int? ?? 0,
      operatorCount: json['operatorCount'] as int? ?? 0,
      activityCount: json['activityCount'] as int? ?? 0,
      epCount: json['epCount'] as int? ?? 0,
    );

Map<String, dynamic> _$CookieInfoCountModelToJson(
        CookieInfoCountModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'skinCount': instance.skinCount,
      'operatorCount': instance.operatorCount,
      'activityCount': instance.activityCount,
      'epCount': instance.epCount,
    };
