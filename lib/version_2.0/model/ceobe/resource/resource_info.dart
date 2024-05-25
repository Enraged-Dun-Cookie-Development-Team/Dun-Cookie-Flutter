import 'package:json_annotation/json_annotation.dart';

part 'resource_info.g.dart';

@JsonSerializable()
class ResourceInfoModel {
  final Resources? resources;
  @JsonKey(defaultValue: [])
  final List<Countdown> countdown;

  ResourceInfoModel({required this.resources, required this.countdown});

  factory ResourceInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourceInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResourceInfoModelToJson(this);
}

@JsonSerializable()
class Resources {
  final String startTime;
  final String overTime;

  Resources({this.startTime = "", this.overTime = ""});

  factory Resources.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourcesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResourcesToJson(this);
}

@JsonSerializable()
class Countdown {
  final String text;
  final String remark;
  final String time;
  final String startTime;
  final String overTime;
  final String? countdownType;

  Countdown(
      {this.text = "",
      this.remark = "",
      this.time = "",
      this.startTime = "",
      this.overTime = "",
      this.countdownType});

  factory Countdown.fromJson(Map<String, dynamic> srcJson) =>
      _$CountdownFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CountdownToJson(this);
}
