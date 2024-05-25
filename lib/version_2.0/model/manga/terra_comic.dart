import 'package:json_annotation/json_annotation.dart';

part 'terra_comic.g.dart';

@JsonSerializable()
class TerraComicModel {
  TerraComicModel({
    this.comic = "",
    this.updateTime = 0,
    this.count = 0,
    this.cover = "",
    this.introduction = "",
    required this.authors,
    required this.keywords,
    this.subtitle = "",
    this.title = "",
  });

  String comic;
  int updateTime;
  int count;
  String cover;
  String introduction;
  List<String> authors;
  List<String> keywords;
  String subtitle;
  String title;

  factory TerraComicModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TerraComicModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TerraComicModelToJson(this);
}
