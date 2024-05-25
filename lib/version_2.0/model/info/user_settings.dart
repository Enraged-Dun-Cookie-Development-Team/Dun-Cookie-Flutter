import 'package:json_annotation/json_annotation.dart';

part 'user_settings.g.dart';

@JsonSerializable()
class DatasourceModel {
  @JsonKey(defaultValue: [])
  List<String> datasourceList;
  String datasourceCombId;

  DatasourceModel({
    required this.datasourceList,
    this.datasourceCombId = "",
  });

  factory DatasourceModel.fromJson(Map<String, dynamic> srcJson) =>
      _$DatasourceModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DatasourceModelToJson(this);
}
