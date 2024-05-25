// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dun_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DunAppModel _$DunAppModelFromJson(Map<String, dynamic> json) => DunAppModel(
      lastForceVersion: json['lastForceVersion'] as String,
      force: json['force'] as bool,
      version: json['version'] as String,
      description: json['description'] as String,
      apk: json['apk'] as String,
      spareApk: json['spareApk'] as String,
      baidu: json['baidu'] as String,
    );

Map<String, dynamic> _$DunAppModelToJson(DunAppModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'force': instance.force,
      'lastForceVersion': instance.lastForceVersion,
      'description': instance.description,
      'apk': instance.apk,
      'spareApk': instance.spareApk,
      'baidu': instance.baidu,
    };
