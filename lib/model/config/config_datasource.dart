import 'package:json_annotation/json_annotation.dart';

part 'config_datasource.g.dart';

@JsonEnum(valueField: "id")
enum Platform {
  bilibili("bilibili", "B站"),
  weibo("weibo", "微博"),
  neteaseCloudMusic("netease-cloud-music", "网易云音乐"),
  arknightsGame("arknights-game", "明日方舟游戏内"),
  arknightsWebsite("arknights-website", "明日方舟网站"),
  other("", "其他");

  const Platform(this.id, this.name);

  final String id;
  final String name;
}

@JsonSerializable(createToJson: false)
class ConfigDatasourceModel {
  @JsonKey(defaultValue: '')
  final String nickname;
  @JsonKey(defaultValue: '')
  final String avatar;
  @JsonKey(name: 'unique_id', defaultValue: '')
  final String uniqueId;
  @JsonKey(name: 'jump_url', defaultValue: '')
  final String jumpUrl;
  @JsonKey(defaultValue: Platform.other, unknownEnumValue: Platform.other)
  final Platform platform;

  ConfigDatasourceModel({
    required this.nickname,
    required this.avatar,
    required this.uniqueId,
    required this.jumpUrl,
    required this.platform,
  });

  factory ConfigDatasourceModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ConfigDatasourceModelFromJson(srcJson);
}
