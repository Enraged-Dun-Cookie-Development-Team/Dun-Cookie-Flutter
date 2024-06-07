// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CookieInfoCountModel _$CookieInfoCountModelFromJson(
        Map<String, dynamic> json) =>
    CookieInfoCountModel(
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
      skinCount: (json['skin_count'] as num?)?.toInt() ?? 0,
      operatorCount: (json['operator_count'] as num?)?.toInt() ?? 0,
      activityCount: (json['activity_count'] as num?)?.toInt() ?? 0,
      epCount: (json['ep_count'] as num?)?.toInt() ?? 0,
    );
