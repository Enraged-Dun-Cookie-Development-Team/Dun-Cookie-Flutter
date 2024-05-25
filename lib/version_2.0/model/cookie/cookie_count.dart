import 'package:json_annotation/json_annotation.dart';

part 'cookie_count.g.dart';

/// "total_count": 78,
/// "skin_count": 2,
/// "operator_count": 0,
/// "activity_count": 6,
/// "ep_count": 0

@JsonSerializable()
class CookieInfoCountModel {
  @JsonKey(defaultValue: 0)
  int totalCount;
  @JsonKey(defaultValue: 0)
  int skinCount;
  @JsonKey(defaultValue: 0)
  int operatorCount;
  @JsonKey(defaultValue: 0)
  int activityCount;
  @JsonKey(defaultValue: 0)
  int epCount;

  CookieInfoCountModel(
      {required this.totalCount,
      required this.skinCount,
      required this.operatorCount,
      required this.activityCount,
      required this.epCount});

  factory CookieInfoCountModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieInfoCountModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CookieInfoCountModelToJson(this);
}
