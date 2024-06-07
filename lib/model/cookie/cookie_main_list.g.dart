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
      nextPageId: json['next_page_id'] as String?,
    );

Cookie _$CookieFromJson(Map<String, dynamic> json) => Cookie(
      datasource: json['datasource'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      timestamp: fromJsonToTimestamp(json['timestamp']),
      defaultCookie: fromJsonToDefaultCookie(json['default_cookie']),
      item: fromJsonToItem(json['item']),
      source: fromJsonToSource(json['source']),
    );

Timestamp _$TimestampFromJson(Map<String, dynamic> json) => Timestamp(
      platform: (json['platform'] as num?)?.toInt() ?? 0,
      platformPrecision: json['platform_precision'] as String? ?? 'none',
      fetcher: (json['fetcher'] as num?)?.toInt() ?? 0,
    );

DefaultCookie _$DefaultCookieFromJson(Map<String, dynamic> json) =>
    DefaultCookie(
      text: json['text'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => CookieImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

CookieImage _$CookieImageFromJson(Map<String, dynamic> json) => CookieImage(
      originUrl: json['origin_url'] as String? ?? '',
      compressUrl: json['compress_url'] as String?,
    );

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String? ?? "",
      url: json['url'] as String? ?? "",
      retweeted: fromJsonToRetweeted(json['retweeted']),
    );

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      type: json['type'] as String? ?? "",
      data: json['data'] as String? ?? "",
    );

Retweeted _$RetweetedFromJson(Map<String, dynamic> json) => Retweeted(
      authorName: json['author_name'] as String? ?? '',
      authorAvatar: json['author_avatar'] as String? ?? '',
      text: json['text'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => CookieImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
