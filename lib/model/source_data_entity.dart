import 'dart:convert';
import 'package:dun_cookie_flutter/generated/json/base/json_field.dart';
import 'package:dun_cookie_flutter/generated/json/source_data_entity.g.dart';

@JsonSerializable()
class SourceDataEntity {
  late String dataSource;
  late String id;
  late int timeForSort;
  String? timeForDisplay;
  String? content;
  String? coverImage;
  String? jumpUrl;
  List<String>? imageList;
  List<String>? imageHttpList;
  String? componentData;
  SourceDataRetweeted? retweeted;
  SourceDataSourceInfo? sourceInfo;

  SourceDataEntity();

  factory SourceDataEntity.fromJson(Map<String, dynamic> json) =>
      $SourceDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $SourceDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SourceDataRetweeted {
  String? name;
  String? content;

  SourceDataRetweeted();

  factory SourceDataRetweeted.fromJson(Map<String, dynamic> json) =>
      $SourceDataRetweetedFromJson(json);

  Map<String, dynamic> toJson() => $SourceDataRetweetedToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SourceDataSourceInfo {
  String? icon;
  String? dataName;
  String? title;
  String? dataUrl;
  String? url;
  int? priority;
  int? uid;

  SourceDataSourceInfo();

  factory SourceDataSourceInfo.fromJson(Map<String, dynamic> json) =>
      $SourceDataSourceInfoFromJson(json);

  Map<String, dynamic> toJson() => $SourceDataSourceInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
