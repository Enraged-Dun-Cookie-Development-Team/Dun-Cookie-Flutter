import 'dart:convert';
import 'package:dun_cookie_flutter/generated/json/base/json_field.dart';
import 'package:dun_cookie_flutter/generated/json/source_data_entity.g.dart';

@JsonSerializable()
class SourceDataEntity {

	late String dataSource;
	late String id;
	late int timeForSort;
	late String timeForDisplay;
	late String content;
	late String jumpUrl;
	late List<String> imageList;
	late List<String> imageHttpList;
	late String coverImage;
	late bool isTop;
	late SourceDataComponentData componentData;
	late SourceDataRetweeted retweeted;
  
  SourceDataEntity();

  factory SourceDataEntity.fromJson(Map<String, dynamic> json) => $SourceDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $SourceDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SourceDataComponentData {


  
  SourceDataComponentData();

  factory SourceDataComponentData.fromJson(Map<String, dynamic> json) => $SourceDataComponentDataFromJson(json);

  Map<String, dynamic> toJson() => $SourceDataComponentDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SourceDataRetweeted {

	late String name;
	late String content;
  
  SourceDataRetweeted();

  factory SourceDataRetweeted.fromJson(Map<String, dynamic> json) => $SourceDataRetweetedFromJson(json);

  Map<String, dynamic> toJson() => $SourceDataRetweetedToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}