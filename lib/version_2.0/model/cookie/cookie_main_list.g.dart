// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_main_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CookieMainListModel _$CookieMainListModelFromJson(Map<String, dynamic> json) =>
    CookieMainListModel(
      cookies: (json['cookies'] as List<dynamic>?)
              ?.map((e) => Cookie.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nextPageId: json['nextPageId'] as String?,
    );

Map<String, dynamic> _$CookieMainListModelToJson(
        CookieMainListModel instance) =>
    <String, dynamic>{
      'cookies': instance.cookies,
      'nextPageId': instance.nextPageId,
    };

Cookie _$CookieFromJson(Map<String, dynamic> json) => Cookie(
      datasource: json['datasource'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
      timestamp: json['timestamp'] == null
          ? null
          : Timestamp.fromJson(json['timestamp'] as Map<String, dynamic>),
      defaultCookie: json['defaultCookie'] == null
          ? null
          : DefaultCookie.fromJson(
              json['defaultCookie'] as Map<String, dynamic>),
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
      source: json['source'] == null
          ? null
          : Source.fromJson(json['source'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CookieToJson(Cookie instance) => <String, dynamic>{
      'datasource': instance.datasource,
      'icon': instance.icon,
      'timestamp': instance.timestamp,
      'defaultCookie': instance.defaultCookie,
      'item': instance.item,
      'source': instance.source,
    };

Timestamp _$TimestampFromJson(Map<String, dynamic> json) => Timestamp(
      platform: json['platform'] as int? ?? 0,
      platformPrecision: json['platformPrecision'] as String? ?? "none",
      fetcher: json['fetcher'] as int? ?? 0,
    );

Map<String, dynamic> _$TimestampToJson(Timestamp instance) => <String, dynamic>{
      'platform': instance.platform,
      'platformPrecision': instance.platformPrecision,
      'fetcher': instance.fetcher,
    };

DefaultCookie _$DefaultCookieFromJson(Map<String, dynamic> json) =>
    DefaultCookie(
      text: json['text'] as String? ?? "",
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => CookieImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DefaultCookieToJson(DefaultCookie instance) =>
    <String, dynamic>{
      'text': instance.text,
      'images': instance.images,
    };

CookieImage _$CookieImageFromJson(Map<String, dynamic> json) => CookieImage(
      originUrl: json['originUrl'] as String? ?? "",
      compressUrl: json['compressUrl'] as String?,
    );

Map<String, dynamic> _$CookieImageToJson(CookieImage instance) =>
    <String, dynamic>{
      'originUrl': instance.originUrl,
      'compressUrl': instance.compressUrl,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String? ?? "",
      url: json['url'] as String? ?? "",
      retweeted: json['retweeted'] == null
          ? null
          : Retweeted.fromJson(json['retweeted'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'retweeted': instance.retweeted,
    };

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      type: json['type'] as String? ?? "",
      data: json['data'] as String? ?? "",
    );

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };

Retweeted _$RetweetedFromJson(Map<String, dynamic> json) => Retweeted(
      authorName: json['authorName'] as String? ?? "",
      authorAvatar: json['authorAvatar'] as String? ?? "",
      text: json['text'] as String? ?? "",
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => CookieImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RetweetedToJson(Retweeted instance) => <String, dynamic>{
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'text': instance.text,
      'images': instance.images,
    };
