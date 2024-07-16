// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDatasourceModel _$UserDatasourceModelFromJson(Map<String, dynamic> json) =>
    UserDatasourceModel(
      datasourceList: (json['datasource_config'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          {},
      datasourceCombId: json['datasource_comb_id'] as String? ?? '',
    );

Map<String, dynamic> _$UserDatasourceModelToJson(
        UserDatasourceModel instance) =>
    <String, dynamic>{
      'datasource_config': instance.datasourceList.toList(),
      'datasource_comb_id': instance.datasourceCombId,
    };
