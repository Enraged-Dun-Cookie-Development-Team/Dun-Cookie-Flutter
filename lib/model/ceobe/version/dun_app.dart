import 'package:json_annotation/json_annotation.dart';

part 'dun_app.g.dart';

@JsonSerializable(createToJson: false)
class DunAppInfoModel {
  @JsonKey(defaultValue: '0.0.0')
  final String version;
  @JsonKey(defaultValue: false)
  final bool force;
  @JsonKey(name: 'last_force_version', defaultValue: '')
  final String lastForceVersion;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: '')
  final String apk;
  @JsonKey(name: 'spare_apk', defaultValue: '')
  final String spareApk;
  @JsonKey(defaultValue: '')
  final String baidu;
  @JsonKey(name: 'baidu_text', defaultValue: '')
  final String baiduRemark;

  DunAppInfoModel({
    required this.lastForceVersion,
    required this.force,
    required this.version,
    required this.description,
    required this.apk,
    required this.spareApk,
    required this.baidu,
    required this.baiduRemark,
  });

  factory DunAppInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DunAppInfoModelFromJson(srcJson);
}
