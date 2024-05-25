import 'package:json_annotation/json_annotation.dart';

/// "cookie_id": "string",
/// "update_cookie_id": "string"

part 'newest_cookie_id.g.dart';

@JsonSerializable()
class NewestCookieIdModel {
  String? cookieId;
  String? updateCookieId;

  NewestCookieIdModel({
    this.cookieId,
    this.updateCookieId,
  });

  factory NewestCookieIdModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NewestCookieIdModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewestCookieIdModelToJson(this);
}
