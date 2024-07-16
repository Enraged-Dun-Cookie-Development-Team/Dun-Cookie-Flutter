import 'package:json_annotation/json_annotation.dart';

part 'terra_comic.g.dart';

@JsonSerializable(createToJson: false)
class TerraComicModel {
  @JsonKey(defaultValue: '')
  String comic;
  @JsonKey(name: 'update_time', defaultValue: 0)
  int updateTime;
  @JsonKey(defaultValue: 0)
  int count;
  @JsonKey(defaultValue: '')
  String cover;
  @JsonKey(defaultValue: '')
  String introduction;
  @JsonKey(defaultValue: [])
  List<String> authors;
  @JsonKey(defaultValue: [])
  List<String> keywords;
  @JsonKey(defaultValue: '')
  String subtitle;
  @JsonKey(defaultValue: '')
  String title;

  TerraComicModel({
    required this.comic,
    required this.updateTime,
    required this.count,
    required this.cover,
    required this.introduction,
    required this.authors,
    required this.keywords,
    required this.subtitle,
    required this.title,
  });

  factory TerraComicModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TerraComicModelFromJson(srcJson);
}
