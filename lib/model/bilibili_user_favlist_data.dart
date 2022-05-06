import 'dart:convert';

import 'bilibili_favorites_data.dart';

/// code : 0
/// message : "0"
/// ttl : 1
/// data : {"count":2,"list":[{"id":1596945616,"fid":15969456,"mid":1579053316,"attr":22,"title":"泰拉每周速递 第一期","fav_state":0,"media_count":9},{"id":1596945916,"fid":15969459,"mid":1579053316,"attr":22,"title":"泰拉每周速递 第二期","fav_state":0,"media_count":11}],"season":null}

BilibiliUserFavlistData userWanFavlistFromJson(String str) =>
    BilibiliUserFavlistData.fromJson(json.decode(str));

String userWanFavlistToJson(BilibiliUserFavlistData data) =>
    json.encode(data.toJson());

class BilibiliUserFavlistData {
  BilibiliUserFavlistData({
    this.code,
    this.message,
    this.ttl,
    this.data,
  });

  BilibiliUserFavlistData.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    ttl = json['ttl'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? code;
  String? message;
  int? ttl;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['ttl'] = ttl;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// count : 2
/// list : [{"id":1596945616,"fid":15969456,"mid":1579053316,"attr":22,"title":"泰拉每周速递 第一期","fav_state":0,"media_count":9},{"id":1596945916,"fid":15969459,"mid":1579053316,"attr":22,"title":"泰拉每周速递 第二期","fav_state":0,"media_count":11}]
/// season : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.count,
    this.list,
    this.season,
  });

  Data.fromJson(dynamic json) {
    count = json['count'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(FavData.fromJson(v));
      });
    }
    season = json['season'];
  }

  int? count;
  List<FavData>? list;
  dynamic season;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    map['season'] = season;
    return map;
  }
}

/// id : 1596945616
/// fid : 15969456
/// mid : 1579053316
/// attr : 22
/// title : "泰拉每周速递 第一期"
/// fav_state : 0
/// media_count : 9

FavData listFromJson(String str) => FavData.fromJson(json.decode(str));

String listToJson(FavData data) => json.encode(data.toJson());

class FavData {
  FavData(
      {this.id,
      this.fid,
      this.mid,
      this.attr,
      this.title,
      this.favState,
      this.mediaCount,
      this.bilibiliFavoritesData});

  FavData.fromJson(dynamic json) {
    id = json['id'];
    fid = json['fid'];
    mid = json['mid'];
    attr = json['attr'];
    title = json['title'];
    favState = json['fav_state'];
    mediaCount = json['media_count'];
  }

  int? id;
  int? fid;
  int? mid;
  int? attr;
  String? title;
  int? favState;
  int? mediaCount;
  BilibiliFavoritesData? bilibiliFavoritesData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fid'] = fid;
    map['mid'] = mid;
    map['attr'] = attr;
    map['title'] = title;
    map['fav_state'] = favState;
    map['media_count'] = mediaCount;
    return map;
  }
}
