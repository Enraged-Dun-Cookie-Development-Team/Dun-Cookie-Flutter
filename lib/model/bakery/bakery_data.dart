import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'bakery_data.g.dart';

BakeryDataModel bakeryDataFromString(String str) =>
    BakeryDataModel.fromJson(json.decode(str));

@JsonSerializable(createToJson: false)
class BakeryDataModel {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String description;
  @JsonKey(defaultValue: '')
  String createTime;
  @JsonKey(name: 'cv_link', defaultValue: '')
  String cvLink;
  @JsonKey(name: 'modify_time', defaultValue: '')
  String modifyTime;
  @JsonKey(defaultValue: 0)
  int fraction;
  @JsonKey(defaultValue: [])
  List<BakeryDaily> daily;

  BakeryDataModel({
    required this.id,
    required this.description,
    required this.createTime,
    required this.modifyTime,
    required this.cvLink,
    required this.fraction,
    required this.daily,
  });

  factory BakeryDataModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryDataModelFromJson(srcJson);
}

@JsonSerializable(createToJson: false)
class BakeryRecentPredictModel {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String description;
  @JsonKey(fromJson: fromJsonToBakeryDaily)
  BakeryDaily daily;

  BakeryRecentPredictModel({
    required this.id,
    required this.description,
    required this.daily,
  });

  factory BakeryRecentPredictModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryRecentPredictModelFromJson(srcJson);
}

BakeryDaily fromJsonToBakeryDaily(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return BakeryDaily.fromJson(srcJson);
  } else {
    return BakeryDaily.fromJson({});
  }
}

@JsonSerializable(createToJson: false)
class BakeryDaily {
  @JsonKey(defaultValue: '')
  String datetime;
  @JsonKey(defaultValue: [])
  List<BakeryInfo> info;
  @JsonKey(defaultValue: '')
  String content;

  BakeryDaily({
    required this.datetime,
    required this.content,
    required this.info,
  });

  factory BakeryDaily.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryDailyFromJson(srcJson);
}

@JsonSerializable(createToJson: false)
class BakeryInfo {
  @JsonKey(name: 'forecast_status', defaultValue: '')
  String forecastStatus;
  @JsonKey(defaultValue: '')
  String forecast;

  BakeryInfo({
    required this.forecastStatus,
    required this.forecast,
  });

  factory BakeryInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryInfoFromJson(srcJson);
}
