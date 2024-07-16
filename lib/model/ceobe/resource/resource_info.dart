import 'package:json_annotation/json_annotation.dart';

part 'resource_info.g.dart';

@JsonSerializable(createToJson: false)
class ResourceInfoModel {
  @JsonKey(fromJson: fromJsonToResources)
  final Resources resources;
  @JsonKey(defaultValue: [])
  final List<Countdown> countdown;

  ResourceInfoModel({required this.resources, required this.countdown});

  factory ResourceInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourceInfoModelFromJson(srcJson);
}

Resources fromJsonToResources(var json) {
  if (json is Map<String, dynamic>) {
    return Resources.fromJson(json);
  }
  return Resources.fromJson({});
}

@JsonSerializable(createToJson: false)
class Resources {
  @JsonKey(name: 'start_time', defaultValue: '1970-01-01')
  final String startTime;
  @JsonKey(name: 'over_time', defaultValue: '1970-01-01')
  final String overTime;

  Resources({required this.startTime, required this.overTime});

  factory Resources.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourcesFromJson(srcJson);
}

@JsonSerializable(createToJson: false)
class Countdown {
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: '')
  final String remark;
  @JsonKey(defaultValue: '')
  final String time;
  @JsonKey(name: 'start_time', defaultValue: '')
  final String startTime;
  @JsonKey(name: 'over_time', defaultValue: '')
  final String overTime;
  @JsonKey(name: 'countdown_type', defaultValue: '')
  final String? countdownType;

  Countdown(
      {required this.text,
      required this.remark,
      required this.time,
      required this.startTime,
      required this.overTime,
      this.countdownType});

  factory Countdown.fromJson(Map<String, dynamic> srcJson) =>
      _$CountdownFromJson(srcJson);
}
