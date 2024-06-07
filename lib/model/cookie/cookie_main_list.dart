import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cookie_main_list.g.dart';

@JsonSerializable(createToJson: false)
class CookieMainListModel {
  @JsonKey(defaultValue: [])
  List<Cookie> cookies;
  @JsonKey(name: 'next_page_id')
  String? nextPageId;

  CookieMainListModel({
    required this.cookies,
    this.nextPageId,
  });

  factory CookieMainListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieMainListModelFromJson(srcJson);
}

@JsonSerializable(createToJson: false)
class Cookie {
  @JsonKey(defaultValue: '')
  final String datasource;
  @JsonKey(defaultValue: '')
  final String icon;
  @JsonKey(fromJson: fromJsonToTimestamp)
  final Timestamp timestamp;
  @JsonKey(name: 'default_cookie', fromJson: fromJsonToDefaultCookie)
  final DefaultCookie defaultCookie;
  @JsonKey(fromJson: fromJsonToItem)
  final Item item;
  @JsonKey(fromJson: fromJsonToSource)
  final Source source;

  Cookie({
    required this.datasource,
    required this.icon,
    required this.timestamp,
    required this.defaultCookie,
    required this.item,
    required this.source,
  });

  factory Cookie.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieFromJson(srcJson);

  Cookie copyWithImageList(
      {List<CookieImage>? images, List<CookieImage>? retweetedImages}) {
    return Cookie(
        datasource: datasource,
        icon: icon,
        timestamp: timestamp,
        defaultCookie: DefaultCookie(
            text: defaultCookie.text, images: images ?? defaultCookie.images),
        item: Item(
            id: item.id,
            url: item.url,
            retweeted: item.retweeted
                ?.copyWithImageList(retweetedImages: retweetedImages)),
        source: source);
  }
}

Timestamp fromJsonToTimestamp(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return Timestamp.fromJson(srcJson);
  } else {
    return Timestamp.fromJson({});
  }
}

@JsonSerializable(createToJson: false)
class Timestamp {
  @JsonKey(defaultValue: 0)
  final int platform;
  @JsonKey(name: 'platform_precision', defaultValue: 'none')
  final String platformPrecision;
  @JsonKey(defaultValue: 0)
  final int fetcher;

  const Timestamp({
    required this.platform,
    required this.platformPrecision,
    required this.fetcher,
  });

  factory Timestamp.fromJson(Map<String, dynamic> srcJson) =>
      _$TimestampFromJson(srcJson);
}

DefaultCookie fromJsonToDefaultCookie(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return DefaultCookie.fromJson(srcJson);
  } else {
    return DefaultCookie.fromJson({});
  }
}

@JsonSerializable(createToJson: false)
class DefaultCookie {
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: [])
  final List<CookieImage> images;

  const DefaultCookie({
    required this.text,
    required this.images,
  });

  factory DefaultCookie.fromJson(Map<String, dynamic> srcJson) =>
      _$DefaultCookieFromJson(srcJson);
}

@JsonSerializable(createToJson: false)
class CookieImage {
  @JsonKey(name: 'origin_url', defaultValue: '')
  final String originUrl;
  @JsonKey(name: 'compress_url')
  final String? compressUrl;

  const CookieImage({
    required this.originUrl,
    this.compressUrl,
  });

  factory CookieImage.fromJson(Map<String, dynamic> srcJson) =>
      _$CookieImageFromJson(srcJson);
}

Item fromJsonToItem(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return Item.fromJson(srcJson);
  } else {
    return Item.fromJson({});
  }
}

@JsonSerializable(createToJson: false)
class Item {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String url;
  @JsonKey(fromJson: fromJsonToRetweeted)
  final Retweeted? retweeted;

  const Item({required this.id, required this.url, this.retweeted});

  factory Item.fromJson(Map<String, dynamic> srcJson) =>
      _$ItemFromJson(srcJson);
}

Source fromJsonToSource(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return Source.fromJson(srcJson);
  } else {
    return Source.fromJson({});
  }
}

@JsonSerializable(createToJson: false)
class Source {
  final String type;
  final String data;

  const Source({
    this.type = "",
    this.data = "",
  });

  factory Source.fromJson(Map<String, dynamic> srcJson) =>
      _$SourceFromJson(srcJson);
}

Retweeted? fromJsonToRetweeted(var srcJson) {
  if (srcJson is Map<String, dynamic>) {
    return Retweeted.fromJson(srcJson);
  } else {
    return null;
  }
}

@JsonSerializable(createToJson: false)
class Retweeted {
  @JsonKey(name: 'author_name', defaultValue: '')
  final String authorName;
  @JsonKey(name: 'author_avatar', defaultValue: '')
  final String authorAvatar;
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: [])
  final List<CookieImage> images;

  const Retweeted({
    required this.authorName,
    required this.authorAvatar,
    required this.text,
    required this.images,
  });

  factory Retweeted.fromJson(Map<String, dynamic> srcJson) =>
      _$RetweetedFromJson(srcJson);

  copyWithImageList({List<CookieImage>? retweetedImages}) {
    return Retweeted(
        authorName: authorName,
        authorAvatar: authorAvatar,
        text: text,
        images: retweetedImages ?? images);
  }
}
