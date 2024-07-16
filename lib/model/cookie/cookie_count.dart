import 'package:json_annotation/json_annotation.dart';

part 'cookie_count.g.dart';

@JsonSerializable(createToJson: false)
class CookieInfoCountModel {
  @JsonKey(name: 'total_count', defaultValue: 0)
  int totalCount;
  @JsonKey(name: 'skin_count', defaultValue: 0)
  int skinCount;
  @JsonKey(name: 'operator_count', defaultValue: 0)
  int operatorCount;
  @JsonKey(name: 'activity_count', defaultValue: 0)
  int activityCount;
  @JsonKey(name: 'ep_count', defaultValue: 0)
  int epCount;

  CookieInfoCountModel(
      {required this.totalCount,
      required this.skinCount,
      required this.operatorCount,
      required this.activityCount,
      required this.epCount});

  factory CookieInfoCountModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieInfoCountModelFromJson(srcJson);
}
