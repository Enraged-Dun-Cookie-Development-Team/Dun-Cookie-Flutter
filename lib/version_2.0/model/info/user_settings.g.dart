// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatasourceModel _$DatasourceModelFromJson(Map<String, dynamic> json) =>
    DatasourceModel(
      datasourceList: (json['datasourceList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      datasourceCombId: json['datasourceCombId'] as String? ?? "",
    );

Map<String, dynamic> _$DatasourceModelToJson(DatasourceModel instance) =>
    <String, dynamic>{
      'datasourceList': instance.datasourceList,
      'datasourceCombId': instance.datasourceCombId,
    };
