// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_datasource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigDatasourceModel _$ConfigDatasourceModelFromJson(
        Map<String, dynamic> json) =>
    ConfigDatasourceModel(
      nickname: json['nickname'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      uniqueId: json['unique_id'] as String? ?? '',
      jumpUrl: json['jump_url'] as String? ?? '',
      platform: $enumDecodeNullable(_$PlatformEnumMap, json['platform'],
              unknownValue: Platform.other) ??
          Platform.other,
    );

const _$PlatformEnumMap = {
  Platform.bilibili: 'bilibili',
  Platform.weibo: 'weibo',
  Platform.neteaseCloudMusic: 'netease-cloud-music',
  Platform.arknightsGame: 'arknights-game',
  Platform.arknightsWebsite: 'arknights-website',
  Platform.other: '',
};
