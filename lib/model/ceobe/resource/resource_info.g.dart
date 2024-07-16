// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceInfoModel _$ResourceInfoModelFromJson(Map<String, dynamic> json) =>
    ResourceInfoModel(
      resources: fromJsonToResources(json['resources']),
      countdown: (json['countdown'] as List<dynamic>?)
              ?.map((e) => Countdown.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Resources _$ResourcesFromJson(Map<String, dynamic> json) => Resources(
      startTime: json['start_time'] as String? ?? '1970-01-01',
      overTime: json['over_time'] as String? ?? '1970-01-01',
    );

Countdown _$CountdownFromJson(Map<String, dynamic> json) => Countdown(
      text: json['text'] as String? ?? '',
      remark: json['remark'] as String? ?? '',
      time: json['time'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      overTime: json['over_time'] as String? ?? '',
      countdownType: json['countdown_type'] as String? ?? '',
    );
