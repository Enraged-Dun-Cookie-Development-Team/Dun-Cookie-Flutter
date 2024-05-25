import 'package:json_annotation/json_annotation.dart';

part 'config_datasource.g.dart';

@JsonSerializable()
class ConfigDatasourceModel {
  String? nickname;
  String? avatar;
  String? uniqueId;
  String? jumpUrl;
  String? platform;

  ConfigDatasourceModel({
    this.nickname,
    this.avatar,
    this.uniqueId,
    this.jumpUrl,
    this.platform,
  });

  factory ConfigDatasourceModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ConfigDatasourceModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ConfigDatasourceModelToJson(this);
}
