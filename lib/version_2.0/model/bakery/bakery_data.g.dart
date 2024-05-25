// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bakery_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BakeryDataModel _$BakeryDataModelFromJson(Map<String, dynamic> json) =>
    BakeryDataModel(
      id: json['id'] as String? ?? "",
      description: json['description'] as String? ?? "",
      createTime: json['createTime'] as String? ?? "",
      modifyTime: json['modifyTime'] as String? ?? "",
      cvLink: json['cvLink'] as String? ?? "",
      fraction: json['fraction'] as int? ?? 0,
      daily: (json['daily'] as List<dynamic>?)
              ?.map((e) => BakeryDaily.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BakeryDataModelToJson(BakeryDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'createTime': instance.createTime,
      'modifyTime': instance.modifyTime,
      'cvLink': instance.cvLink,
      'fraction': instance.fraction,
      'daily': instance.daily,
    };

BakeryRecentPredictModel _$BakeryRecentPredictModelFromJson(
        Map<String, dynamic> json) =>
    BakeryRecentPredictModel(
      id: json['id'] as String? ?? "",
      description: json['description'] as String? ?? "",
      daily: BakeryDaily.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BakeryRecentPredictModelToJson(
        BakeryRecentPredictModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'daily': instance.daily,
    };

BakeryDaily _$BakeryDailyFromJson(Map<String, dynamic> json) => BakeryDaily(
      datetime: json['datetime'] as String? ?? "",
      content: json['content'] as String? ?? "",
      info: (json['info'] as List<dynamic>?)
              ?.map((e) => BakeryInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$BakeryDailyToJson(BakeryDaily instance) =>
    <String, dynamic>{
      'datetime': instance.datetime,
      'info': instance.info,
      'content': instance.content,
    };

BakeryInfo _$BakeryInfoFromJson(Map<String, dynamic> json) => BakeryInfo(
      forecastStatus: json['forecastStatus'] as String? ?? "",
      forecast: json['forecast'] as String? ?? "",
    );

Map<String, dynamic> _$BakeryInfoToJson(BakeryInfo instance) =>
    <String, dynamic>{
      'forecastStatus': instance.forecastStatus,
      'forecast': instance.forecast,
    };
