import 'package:json_annotation/json_annotation.dart';

part 'cookie_main_list.g.dart';

/// "cookies": [
///   {
///     "datasource": "明日方舟-B站",
///     "icon": "http://test-cdn.ceobecanteen.top/data-source-avatar/43adadbd-b2cf-4f79-8f3d-33429e0cb534",
///     "timestamp": {
///       "platform": 1668567695000,
///       "platformPrecision": "second",
///       "fetcher": 1669529505515
///     }
///     "default_cookie": {
///       "text": "【新增服饰】\n//灵巧侍者 - 耶拉\nEPOQUE系列新款/灵巧侍者。耶拉在萨维尔衣匠处定制的衣物，由于耶拉本人的巧妙点子与设计者的奇思妙想，成衣产生了预料之外的效果。\n_____________\n如果不是耶拉在定制衣物前看了点维多利亚传统童话故事，初雪或许捕捉不到银灰那饱含疑惑的皱眉瞬间。若是问耶拉自己的感想？她玩得很开心。",
///       "images": [
///         "https://i0.hdslb.com/bfs/new_dyn/84eee24c70e47f7f7990c72e5cbbba92161775300.png",
///         "https://i0.hdslb.com/bfs/new_dyn/73f9e54e3c7914e79e577257c88c4942161775300.gif",
///         "https://i0.hdslb.com/bfs/new_dyn/884a2e9e2e84faa4cfc6bf7d5c80ee78161775300.gif",
///         "https://i0.hdslb.com/bfs/new_dyn/5e3d3309568ee22bf184191008eed185161775300.gif",
///         "https://i0.hdslb.com/bfs/new_dyn/32577be3c9e37532b2abaa937134af50161775300.gif"
///       ]
///     },
///     "item": {
///       "id": "814046214396837987",
///       "url": "https://t.bilibili.com/814046214396837987",
///       "type": "DYNAMIC_TYPE_DRAW",
///       "is_top": false,
///       "is_retweeted": false
///     },
///     "source": {
///       "type": "weibo:dynamic-by-uid",
///       "data": "6279793937",
///     }
///   }
/// ],
/// "next_page_id": "644a96ce34422f48cd20bdef"
@JsonSerializable()
class CookieMainListModel {
  @JsonKey(defaultValue: [])
  List<Cookie> cookies;
  String? nextPageId;

  CookieMainListModel({
    required this.cookies,
    this.nextPageId,
  });

  factory CookieMainListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieMainListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CookieMainListModelToJson(this);
}

///     "datasource": "明日方舟-B站",
///     "icon": "http://test-cdn.ceobecanteen.top/data-source-avatar/43adadbd-b2cf-4f79-8f3d-33429e0cb534",
///     "timestamp": {
///       "platform": 1668567695000,
///       "platformPrecision": "second",
///       "fetcher": 1669529505515
///     }
///     "default_cookie": {
///       "text": "【新增服饰】\n//灵巧侍者 - 耶拉\nEPOQUE系列新款/灵巧侍者。耶拉在萨维尔衣匠处定制的衣物，由于耶拉本人的巧妙点子与设计者的奇思妙想，成衣产生了预料之外的效果。\n_____________\n如果不是耶拉在定制衣物前看了点维多利亚传统童话故事，初雪或许捕捉不到银灰那饱含疑惑的皱眉瞬间。若是问耶拉自己的感想？她玩得很开心。",
///       "images": [
///         "https://i0.hdslb.com/bfs/new_dyn/84eee24c70e47f7f7990c72e5cbbba92161775300.png",
///         "https://i0.hdslb.com/bfs/new_dyn/73f9e54e3c7914e79e577257c88c4942161775300.gif",
///         "https://i0.hdslb.com/bfs/new_dyn/884a2e9e2e84faa4cfc6bf7d5c80ee78161775300.gif",
///         "https://i0.hdslb.com/bfs/new_dyn/5e3d3309568ee22bf184191008eed185161775300.gif",
///         "https://i0.hdslb.com/bfs/new_dyn/32577be3c9e37532b2abaa937134af50161775300.gif"
///       ]
///     }
///     "item": {
///       "id": "814046214396837987",
///       "url": "https://t.bilibili.com/814046214396837987",
///       "type": "DYNAMIC_TYPE_DRAW",
///       "is_top": false,
///       "is_retweeted": false
///     },
///     "source": {
///       "type": "weibo:dynamic-by-uid",
///       "data": "6279793937",
///     }
@JsonSerializable()
class Cookie {
  final String datasource;
  final String icon;
  final Timestamp? timestamp;
  final DefaultCookie? defaultCookie;
  final Item? item;
  final Source? source;

  Cookie({
    this.datasource = "",
    this.icon = "",
    this.timestamp,
    this.defaultCookie,
    this.item,
    this.source,
  });

  factory Cookie.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CookieToJson(this);
}

@JsonSerializable()
class Timestamp {
  final int platform;
  final String platformPrecision;
  final int fetcher;

  const Timestamp({
    this.platform = 0,
    this.platformPrecision = "none",
    this.fetcher = 0,
  });

  factory Timestamp.fromJson(Map<String, dynamic> srcJson) =>
      _$TimestampFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimestampToJson(this);
}

@JsonSerializable()
class DefaultCookie {
  final String text;
  @JsonKey(defaultValue: [])
  final List<CookieImage> images;

  const DefaultCookie({
    this.text = "",
    required this.images,
  });

  factory DefaultCookie.fromJson(Map<String, dynamic> srcJson) =>
      _$DefaultCookieFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DefaultCookieToJson(this);
}

@JsonSerializable()
class CookieImage {
  final String originUrl;
  final String? compressUrl;

  const CookieImage({
    this.originUrl = "",
    this.compressUrl,
  });

  factory CookieImage.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieImageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CookieImageToJson(this);
}

@JsonSerializable()
class Item {
  final String id;
  final String url;
  final Retweeted? retweeted;

  const Item({this.id = "", this.url = "", this.retweeted});

  factory Item.fromJson(Map<String, dynamic> srcJson) =>
      _$ItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Source {
  final String type;
  final String data;

  const Source({
    this.type = "",
    this.data = "",
  });

  factory Source.fromJson(Map<String, dynamic> srcJson) =>
      _$SourceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

@JsonSerializable()
class Retweeted {
  final String authorName;
  final String authorAvatar;
  final String text;
  @JsonKey(defaultValue: [])
  final List<CookieImage> images;

  const Retweeted({
    this.authorName = "",
    this.authorAvatar = "",
    this.text = "",
    required this.images,
  });

  factory Retweeted.fromJson(Map<String, dynamic> srcJson) =>
      _$RetweetedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RetweetedToJson(this);
}
