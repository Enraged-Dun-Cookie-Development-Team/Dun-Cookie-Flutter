// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceInfoModel _$ResourceInfoModelFromJson(Map<String, dynamic> json) =>
    ResourceInfoModel(
      resources: json['resources'] == null
          ? null
          : Resources.fromJson(json['resources'] as Map<String, dynamic>),
      countdown: (json['countdown'] as List<dynamic>?)
              ?.map((e) => Countdown.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ResourceInfoModelToJson(ResourceInfoModel instance) =>
    <String, dynamic>{
      'resources': instance.resources,
      'countdown': instance.countdown,
    };

Resources _$ResourcesFromJson(Map<String, dynamic> json) => Resources(
      startTime: json['startTime'] as String? ?? "",
      overTime: json['overTime'] as String? ?? "",
    );

Map<String, dynamic> _$ResourcesToJson(Resources instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'overTime': instance.overTime,
    };

Countdown _$CountdownFromJson(Map<String, dynamic> json) => Countdown(
      text: json['text'] as String? ?? "",
      remark: json['remark'] as String? ?? "",
      time: json['time'] as String? ?? "",
      startTime: json['startTime'] as String? ?? "",
      overTime: json['overTime'] as String? ?? "",
      countdownType: json['countdownType'] as String?,
    );

Map<String, dynamic> _$CountdownToJson(Countdown instance) => <String, dynamic>{
      'text': instance.text,
      'remark': instance.remark,
      'time': instance.time,
      'startTime': instance.startTime,
      'overTime': instance.overTime,
      'countdownType': instance.countdownType,
    };
