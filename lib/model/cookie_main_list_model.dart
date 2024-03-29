

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
class CookieMainListModel {
  CookieMainListModel({
      this.cookies, 
      this.nextPageId,});

  CookieMainListModel.fromJson(dynamic json) {
    if (json['cookies'] != null) {
      cookies = [];
      json['cookies'].forEach((v) {
        cookies!.add(Cookies.fromJson(v));
      });
    }
    nextPageId = json['next_page_id'];
  }
  List<Cookies>? cookies;
  String? nextPageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cookies'] = cookies != null ? cookies!.map((v) => v.toJson()).toList() : null;
    map['next_page_id'] = nextPageId;
    return map;
  }

}

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
class DefaultCookie {
  DefaultCookie({
    this.text,
    this.images,});

  DefaultCookie.fromJson(dynamic json) {
    text = json['text'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(CookieImage.fromJson(v));
      });
    }
  }
  String? text;
  List<CookieImage>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['images'] = images;
    return map;
  }
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
class Cookies {
  Cookies({
    this.datasource,
    this.icon,
    this.timestamp,
    this.defaultCookie,
    this.item,
    this.source});

  Cookies.fromJson(dynamic json) {
    datasource = json['datasource'];
    icon = json['icon'];
    jumpUrl = json['jump_url'];
    timestamp = json['timestamp'] != null ? Timestamp.fromJson(json['timestamp']) : null;
    defaultCookie = json['default_cookie'] != null ? DefaultCookie.fromJson(json['default_cookie']) : null;
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
  }
  String? datasource;
  String? icon;
  String? jumpUrl;
  Timestamp? timestamp;
  DefaultCookie? defaultCookie;
  Item? item;
  Source? source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['datasource'] = datasource;
    map['icon'] = icon;
    map['jump_url'] = jumpUrl;
    map['timestamp'] = timestamp != null ? timestamp!.toJson() : null;
    map['default_cookie'] = defaultCookie != null ? defaultCookie!.toJson() : null;
    map['item'] = item != null ? item!.toJson() : null;
    map['source'] = item != null ? source!.toJson() : null;

    return map;
  }
}

/// "platform": 1668567695000,
/// "platformPrecision": "second",
/// "fetcher": 1669529505515
class Timestamp {
  Timestamp({
    this.platform,
    this.platformPrecision,
    this.fetcher,});

  Timestamp.fromJson(dynamic json) {
    platform = json['platform'];
    platformPrecision = json['platform_precision'];
    fetcher = json['fetcher'];
  }
  int? platform;
  String? platformPrecision;
  int? fetcher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['platform'] = platform;
    map['platform_precision'] = platformPrecision;
    map['fetcher'] = fetcher;
    return map;
  }

}

class CookieImage {
  CookieImage({
    this.originUrl,
    this.compressUrl,});

  CookieImage.fromJson(dynamic json) {
    originUrl = json['origin_url'];
    compressUrl = json['compress_url'];
  }
  String? originUrl;
  String? compressUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_url'] = originUrl;
    map['compress_url'] = compressUrl;
    return map;
  }
}

/// "id": "814046214396837987",
/// "url": "https://t.bilibili.com/814046214396837987",
/// "type": "DYNAMIC_TYPE_DRAW",
/// "is_top": false,
/// "is_retweeted": false
class Item {
  Item({
    this.id,
    this.url,
    this.retweeted});

  Item.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    retweeted = json['retweeted'] != null ? Retweeted.fromJson(json['retweeted']) : null;
  }
  String? id;
  String? url;
  Retweeted? retweeted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['compress_url'] = url;
    map['retweeted'] = retweeted != null ? retweeted!.toJson() : null;
    return map;
  }
}

/// "type": "weibo:dynamic-by-uid",
/// "data": "6279793937",
class Source {
  Source({
    this.type,
    this.data,});

  Source.fromJson(dynamic json) {
    type = json['type'];
    data = json['data'];
  }
  String? type;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['data'] = data;
    return map;
  }
}

/// "author_name": "明日方舟",
/// "author_avatar": "url",
/// "default_cookie": {
///    "text": "【新增服饰】\n//灵巧侍者 - 耶拉\nEPOQUE系列新款/灵巧侍者。耶拉在萨维尔衣匠处定制的衣物，由于耶拉本人的巧妙点子与设计者的奇思妙想，成衣产生了预料之外的效果。\n_____________\n如果不是耶拉在定制衣物前看了点维多利亚传统童话故事，初雪或许捕捉不到银灰那饱含疑惑的皱眉瞬间。若是问耶拉自己的感想？她玩得很开心。",
///    "images": [
///       "https://i0.hdslb.com/bfs/new_dyn/84eee24c70e47f7f7990c72e5cbbba92161775300.png",
///       "https://i0.hdslb.com/bfs/new_dyn/73f9e54e3c7914e79e577257c88c4942161775300.gif",
///       "https://i0.hdslb.com/bfs/new_dyn/884a2e9e2e84faa4cfc6bf7d5c80ee78161775300.gif",
///       "https://i0.hdslb.com/bfs/new_dyn/5e3d3309568ee22bf184191008eed185161775300.gif",
///       "https://i0.hdslb.com/bfs/new_dyn/32577be3c9e37532b2abaa937134af50161775300.gif"
///    ]
/// }
class Retweeted {
  Retweeted({
    this.authorName,
    this.authorAvatar,
    this.text,
    this.images,});

  Retweeted.fromJson(dynamic json) {
    authorName = json['author_name'];
    authorAvatar = json['author_avatar'];
    text = json['text'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(CookieImage.fromJson(v));
      });
    }
  }
  String? authorName;
  String? authorAvatar;
  String? text;
  List<CookieImage>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author_name'] = authorName;
    map['author_avatar'] = authorAvatar;
    map['text'] = text;
    map['images'] = images;
    return map;
  }
}

