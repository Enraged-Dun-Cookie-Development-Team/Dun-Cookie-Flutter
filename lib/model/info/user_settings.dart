import 'package:json_annotation/json_annotation.dart';

part 'user_settings.g.dart';

@JsonSerializable()
class UserDatasourceModel {
  @JsonKey(name: 'datasource_config', defaultValue: {})
  Set<String> datasourceList;
  @JsonKey(name: 'datasource_comb_id',defaultValue: '')
  String datasourceCombId;

  UserDatasourceModel({
    required this.datasourceList,
    required this.datasourceCombId,
  });

  factory UserDatasourceModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserDatasourceModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserDatasourceModelToJson(this);
}
