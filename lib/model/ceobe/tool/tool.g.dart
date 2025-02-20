// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolModel _$ToolModelFromJson(Map<String, dynamic> json) => ToolModel(
      nameSet: _fromJsonToToolNameSet(json['localized_name']),
      icon: json['icon_url'] as String? ?? '',
      links: (json['links'] as List<dynamic>?)
              ?.map((e) => ToolLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

ToolNameSet _$ToolNameSetFromJson(Map<String, dynamic> json) => ToolNameSet(
      json['zh_CN'] as String? ?? '',
      json['en_US'] as String? ?? '',
    );

ToolLink _$ToolLinkFromJson(Map<String, dynamic> json) => ToolLink(
      primary: json['primary'] as bool? ?? false,
      url: json['url'] as String? ?? '',
    );
