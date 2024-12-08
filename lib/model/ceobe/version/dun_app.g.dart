// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dun_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DunAppInfoModel _$DunAppInfoModelFromJson(Map<String, dynamic> json) =>
    DunAppInfoModel(
      previousMandatoryVersion:
          json['previous_mandatory_version'] as String? ?? '',
      version: json['version'] as String? ?? '0.0.0',
      description: json['description'] as String? ?? '',
      platform: json['platform'] as String? ?? '',
      downloadSources: (json['download_source'] as List<dynamic>?)
              ?.map((e) =>
                  DownloadSourceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

DownloadSourceModel _$DownloadSourceModelFromJson(Map<String, dynamic> json) =>
    DownloadSourceModel(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      primaryUrl: _fromJsonToDownloadUrlModel(json['primary_url']),
      spareUrls: (json['spare_urls'] as List<dynamic>?)
              ?.map((e) => DownloadUrlModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

DownloadUrlModel _$DownloadUrlModelFromJson(Map<String, dynamic> json) =>
    DownloadUrlModel(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
      manual: json['manual'] as bool? ?? true,
      supportPlatforms: (json['support_platforms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
