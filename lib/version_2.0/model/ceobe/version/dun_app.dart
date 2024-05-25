import 'package:json_annotation/json_annotation.dart';

part 'dun_app.g.dart';

@JsonSerializable()
class DunAppModel {
  final String version;
  final bool force;
  final String lastForceVersion;
  final String description;
  final String apk;
  final String spareApk;
  final String baidu;

  DunAppModel({
    required this.lastForceVersion,
    required this.force,
    required this.version,
    required this.description,
    required this.apk,
    required this.spareApk,
    required this.baidu,
  });

  factory DunAppModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DunAppModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DunAppModelToJson(this);
}
