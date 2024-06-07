// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dun_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DunAppInfoModel _$DunAppInfoModelFromJson(Map<String, dynamic> json) =>
    DunAppInfoModel(
      lastForceVersion: json['last_force_version'] as String? ?? '',
      force: json['force'] as bool? ?? false,
      version: json['version'] as String? ?? '',
      description: json['description'] as String? ?? '',
      apk: json['apk'] as String? ?? '',
      spareApk: json['spare_apk'] as String? ?? '',
      baidu: json['baidu'] as String? ?? '',
      baiduRemark: json['baidu_text'] as String? ?? '',
    );
