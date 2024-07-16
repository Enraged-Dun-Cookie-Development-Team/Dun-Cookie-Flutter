// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bakery_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BakeryDataModel _$BakeryDataModelFromJson(Map<String, dynamic> json) =>
    BakeryDataModel(
      id: json['id'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createTime: json['createTime'] as String? ?? '',
      modifyTime: json['modify_time'] as String? ?? '',
      cvLink: json['cv_link'] as String? ?? '',
      fraction: (json['fraction'] as num?)?.toInt() ?? 0,
      daily: (json['daily'] as List<dynamic>?)
              ?.map((e) => BakeryDaily.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

BakeryRecentPredictModel _$BakeryRecentPredictModelFromJson(
        Map<String, dynamic> json) =>
    BakeryRecentPredictModel(
      id: json['id'] as String? ?? '',
      description: json['description'] as String? ?? '',
      daily: fromJsonToBakeryDaily(json['daily']),
    );

BakeryDaily _$BakeryDailyFromJson(Map<String, dynamic> json) => BakeryDaily(
      datetime: json['datetime'] as String? ?? '',
      content: json['content'] as String? ?? '',
      info: (json['info'] as List<dynamic>?)
              ?.map((e) => BakeryInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

BakeryInfo _$BakeryInfoFromJson(Map<String, dynamic> json) => BakeryInfo(
      forecastStatus: json['forecast_status'] as String? ?? '',
      forecast: json['forecast'] as String? ?? '',
    );
