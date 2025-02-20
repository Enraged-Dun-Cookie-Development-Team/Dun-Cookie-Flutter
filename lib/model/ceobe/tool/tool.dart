import 'package:json_annotation/json_annotation.dart';

part 'tool.g.dart';

@JsonSerializable(createToJson: false)
class ToolModel {
  @JsonKey(name: 'localized_name', fromJson: _fromJsonToToolNameSet)
  final ToolNameSet nameSet;
  @JsonKey(name: 'icon_url', defaultValue: '')
  final String icon;
  @JsonKey(name: 'links', defaultValue: [])
  final List<ToolLink> links;

  ToolModel({required this.nameSet, required this.icon, required this.links});

  factory ToolModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ToolModelFromJson(srcJson);

  //TODO: 国际化
  String get url {
    for (var element in links) {
      if (element.primary) {
        return element.url;
      }
    }
    return '';
  }
}

ToolNameSet _fromJsonToToolNameSet(var json) {
  if (json is Map<String, dynamic>) {
    return ToolNameSet.fromJson(json);
  }
  return ToolNameSet.fromJson({});
}

@JsonSerializable(createToJson: false)
class ToolNameSet {
  @JsonKey(name: 'zh_CN', defaultValue: '')
  final String zh;
  @JsonKey(name: 'en_US', defaultValue: '')
  final String en;

  ToolNameSet(this.zh, this.en);

  factory ToolNameSet.fromJson(Map<String, dynamic> srcJson) =>
      _$ToolNameSetFromJson(srcJson);

  //TODO: 国际化
  String get localName => zh;
}

@JsonSerializable(createToJson: false)
class ToolLink {
  @JsonKey(defaultValue: false)
  final bool primary;
  @JsonKey(defaultValue: '')
  final String url;

  ToolLink({required this.primary, required this.url});

  factory ToolLink.fromJson(Map<String, dynamic> srcJson) =>
      _$ToolLinkFromJson(srcJson);
}
