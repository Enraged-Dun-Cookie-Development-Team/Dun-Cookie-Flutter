// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_datasource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigDatasourceModel _$ConfigDatasourceModelFromJson(
        Map<String, dynamic> json) =>
    ConfigDatasourceModel(
      nickname: json['nickname'] as String?,
      avatar: json['avatar'] as String?,
      uniqueId: json['uniqueId'] as String?,
      jumpUrl: json['jumpUrl'] as String?,
      platform: json['platform'] as String?,
    );

Map<String, dynamic> _$ConfigDatasourceModelToJson(
        ConfigDatasourceModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'uniqueId': instance.uniqueId,
      'jumpUrl': instance.jumpUrl,
      'platform': instance.platform,
    };
