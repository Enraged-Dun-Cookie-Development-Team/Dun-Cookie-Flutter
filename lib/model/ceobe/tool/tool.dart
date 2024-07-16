import 'package:json_annotation/json_annotation.dart';

part 'tool.g.dart';

@JsonSerializable(createToJson: false)
class ToolModel {
  final String nickname;
  final String avatar;
  @JsonKey(name: 'jump_url')
  final String url;

  ToolModel(
      {required this.nickname, required this.avatar, required this.url});

  factory ToolModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ToolModelFromJson(srcJson);
}
