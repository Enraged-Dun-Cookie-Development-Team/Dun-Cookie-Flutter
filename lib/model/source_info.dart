import 'dart:convert';

import 'package:flutter/cupertino.dart';

class SourceList {
  static List<dynamic> _sourceList = [];
  static getSourceList() {
    _sourceList = [];
    _sourceList.add(SourceInfo.getMap("bili.ico", "官方B站动态", "哔哩哔哩", 0,
        type: "bili", uid: 161775300));
    _sourceList.add(SourceInfo.getMap("weibo.png", "官方微博", "微博", 1,
        type: "weibo", uid: 6279793937));
    _sourceList.add(SourceInfo.getMap('txz.jpg', '游戏内公告', '通讯组', 2,
        dataUrl:
            'https://ak-conf.hypergryph.com/config/prod/announce_meta/Android/announcement.meta.json'));
    _sourceList.add(SourceInfo.getMap("cho3Weibo.jpg", "朝陇山微博", "朝陇山", 3,
        type: "weibo", uid: 6441489862));
    _sourceList.add(SourceInfo.getMap("ys3Weibo.jpg", "一拾山微博", "一拾山", 4,
        type: "weibo", uid: 7506039414));
    _sourceList.add(SourceInfo.getMap('sr.png', '塞壬唱片官网', '通讯组', 5,
        dataUrl: 'https://monster-siren.hypergryph.com/api/news'));
    _sourceList.add(SourceInfo.getMap("tlWeibo.jpg", "泰拉记事社微博", "泰拉记事社微博", 6,
        type: "weibo", uid: 7499841383));
    _sourceList.add(SourceInfo.getMap('mrfz.ico', '官网', '通讯组', 7,
        dataUrl: 'https://ak.hypergryph.com/'));
    _sourceList.add(SourceInfo.getMap('tl.jpg', '泰拉记事社官网', '泰拉记事社官网', 8,
        dataUrl: 'https://terra-historicus.hypergryph.com/api/comic'));
    _sourceList.add(SourceInfo.getMap('sr.png', '塞壬唱片网易云音乐', '网易云音乐', 9,
        dataUrl: 'http://music.163.com/api/artist/albums/32540734'));
    _sourceList.add(SourceInfo.getMap("yjwb.jpg", "鹰角网络微博", "鹰角网络微博", 10,
        type: "weibo", uid: 7461423907));
    return _sourceList;
  }
}

/// icon : ""
/// dataName : ""
/// title : ""
/// dataUrl : ""
/// url : ""
/// priority : 0
/// uid : 0

SourceInfo sourceInfoFromJson(String str) =>
    SourceInfo.fromJson(json.decode(str));

String sourceInfoToJson(SourceInfo data) => json.encode(data.toJson());

class SourceInfo with ChangeNotifier {
  SourceInfo({
    required this.icon,
    required this.dataName,
    required this.title,
    this.dataUrl,
    this.url,
    this.priority,
    this.uid,
  });

  SourceInfo.fromJson(dynamic json) {
    icon = json.icon;
    dataName = json.dataName;
    title = json.title;
    dataUrl = json.dataUrl;
    url = json.url;
    priority = json.priority;
    uid = json.uid;
  }

  late String icon;
  late String dataName;
  late String title;
  String? dataUrl;
  String? url;
  int? priority;
  int? uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['dataName'] = dataName;
    map['title'] = title;
    map['dataUrl'] = dataUrl;
    map['url'] = url;
    map['priority'] = priority;
    map['uid'] = uid;
    return map;
  }

  static getMap(icon, dataName, title, priority, {dataUrl, uid, type, url}) {
    var sourceItem = SourceInfo(
        icon: icon,
        dataName: dataName,
        title: title,
        dataUrl: dataUrl,
        url: url,
        priority: priority,
        uid: uid);
    if (uid != null && type != null) {
      if (type == "bili") {
        sourceItem.dataUrl = SourceInfo.buildBiliUrl(uid);
      } else if (type == "weibo") {
        sourceItem.dataUrl = SourceInfo.buildWeiboUrl(uid);
      }
    }
    sourceItem.icon = "assets/sources_logo/$icon";
    return {
      "priority": sourceItem.priority,
      "data": sourceItem
    };
  }

  static getSourceInfoInDataName(String name) {}

  static buildBiliUrl(uid) {
    return "https://api.vc.bilibili.com/dynamic_svr/v1/dynamic_svr/space_history?host_uid=$uid&offset_dynamic_id=0&need_top=0&platform=web";
  }

  static buildWeiboUrl(uid) {
    return "https://m.weibo.cn/api/container/getIndex?type=uid&value=$uid&containerid=107603$uid";
  }
}
