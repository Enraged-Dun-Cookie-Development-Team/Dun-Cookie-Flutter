import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'source_info.dart';

/// dataSource : "一拾山微博"
/// id : "一拾山微博_7506039414/L87mt1F32"
/// timeForSort : 1640664005000
/// timeForDisplay : "2021-12-28 12:00:05"
/// content : "#一拾山# #过载突破# #转发抽奖# \n#一拾山新品图鉴# \n一拾山首期独立原创服饰，过载突破系列，晚冬来袭。\n*关注@一拾山 并转发本条微博，我们将于1月3日抽取10位客人，赠送200CNY无门槛优惠券一张。\n以趣味调和模块，我们的明天将被即刻触发。\nload state 100%\n=====================\n【上架时间】\n 现 ..."
/// jumpUrl : "https://weibo.com/7506039414/L87mt1F32"
/// coverImage : "http://wx3.sinaimg.cn/bmiddle/008bYzJQgy1gxsorjfa58j30dw0dwq4e.jpg"
/// imageList : ["https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjfa58j30dw0dwq4e","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjgdccj30dw0dwabs","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjgkvaj30dw0dwta3","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjg3vwj30dw0dwmyx","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjgarhj30dw0dwab1","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjk296j30dw0dwt9u","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjlocfj30dw0dwmzp","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjojnlj30dw0dwacc","https://wx1.sinaimg.cn/large/008bYzJQgy1gxsorjqijuj30dw0dwwgs"]
/// imageHttpList : ["http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjfa58j30dw0dwq4e","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjgdccj30dw0dwabs","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjgkvaj30dw0dwta3","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjg3vwj30dw0dwmyx","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjgarhj30dw0dwab1","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjk296j30dw0dwt9u","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjlocfj30dw0dwmzp","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjojnlj30dw0dwacc","http://wx3.sinaimg.cn/large/008bYzJQgy1gxsorjqijuj30dw0dwwgs"]
/// isTop : true
/// retweeted : {"name":"一拾山","content":"#一拾山# #转发抽奖# \n双十一购物狂欢节的余温还未散去，双十二已悄然而至。\n关注@一拾山 并转发本条微博，我们将于12月11日22:00抽取2位客人，赠送300CNY无门槛优惠券一张。\n=====================\n跨店满减\n活动时间：2021年12月12日 00:00:00 - 2021年12月14日 23:59:59\n活动优惠：每满199减25元\n== ..."}
/// componentData : "123"
/// sourceInfo : {"icon":"","dataName":"","title":"","dataUrl":"","url":"","priority":0,"uid":0}

SourceData SourceDataFromJson(String str) =>
    SourceData.fromJson(json.decode(str));

String SourceDataToJson(SourceData data) => json.encode(data.toJson());

class SourceData {
  SourceData({
    this.dataSource,
    this.id,
    this.timeForSort,
    this.timeForDisplay,
    this.content,
    this.jumpUrl,
    this.coverImage,
    this.imageList,
    this.imageHttpList,
    this.isTop,
    this.retweeted,
    this.componentData,
    this.sourceInfo,
  });

  SourceData? _data;

  setSourceData(SourceData data) {
    _data = data;
  }

  SourceData? get sourceData {
    return _data;
  }

  SourceData.fromJson(dynamic json) {
    dataSource = json['dataSource'];
    id = json['id'];
    timeForSort = json['timeForSort'];
    timeForDisplay = json['timeForDisplay'];
    content = json['content'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'];
    imageList =
        json['imageList'] != null ? json['imageList'].cast<String>() : [];
    imageHttpList = json['imageHttpList'] != null
        ? json['imageHttpList'].cast<String>()
        : [];
    isTop = json['isTop'];
    retweeted = json['retweeted'] != null
        ? Retweeted.fromJson(json['retweeted'])
        : null;
    componentData = json['componentData'];
    sourceInfo = (json['sourceInfo'] != null
        ? SourceInfo.fromJson(json['sourceInfo'])
        : null)!;
  }

  String? dataSource;
  String? id;
  int? timeForSort;
  String? timeForDisplay;
  String? content;
  String? jumpUrl;
  String? coverImage;
  List<String>? imageList;
  List<String>? imageHttpList;
  bool? isTop;
  Retweeted? retweeted;
  Map<String, dynamic>? componentData;
  SourceInfo? sourceInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dataSource'] = dataSource;
    map['id'] = id;
    map['timeForSort'] = timeForSort;
    map['timeForDisplay'] = timeForDisplay;
    map['content'] = content;
    map['jumpUrl'] = jumpUrl;
    map['coverImage'] = coverImage;
    map['imageList'] = imageList;
    map['imageHttpList'] = imageHttpList;
    map['isTop'] = isTop;
    if (retweeted != null) {
      map['retweeted'] = retweeted?.toJson();
    }
    map['componentData'] = componentData;
    if (sourceInfo != null) {
      map['sourceInfo'] = sourceInfo!.toJson();
    }
    return map;
  }
}

/// name : "一拾山"
/// content : "#一拾山# #转发抽奖# \n双十一购物狂欢节的余温还未散去，双十二已悄然而至。\n关注@一拾山 并转发本条微博，我们将于12月11日22:00抽取2位客人，赠送300CNY无门槛优惠券一张。\n=====================\n跨店满减\n活动时间：2021年12月12日 00:00:00 - 2021年12月14日 23:59:59\n活动优惠：每满199减25元\n== ..."

Retweeted retweetedFromJson(String str) => Retweeted.fromJson(json.decode(str));

String retweetedToJson(Retweeted data) => json.encode(data.toJson());

class Retweeted {
  Retweeted({
    this.name,
    this.content,
  });

  Retweeted.fromJson(dynamic json) {
    name = json['name'];
    content = json['content'];
  }

  String? name;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['content'] = content;
    return map;
  }
}
