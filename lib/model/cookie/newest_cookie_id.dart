import 'package:json_annotation/json_annotation.dart';

/// "cookie_id": "string",
/// "update_cookie_id": "string"

part 'newest_cookie_id.g.dart';

@JsonSerializable(createToJson: false)
class NewestCookieIdModel {
  @JsonKey(name: 'cookie_id', defaultValue: '')
  String cookieId;
  @JsonKey(name: 'update_cookie_id', defaultValue: '')
  String updateCookieId;

  NewestCookieIdModel({
    required this.cookieId,
    required this.updateCookieId,
  });

  factory NewestCookieIdModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NewestCookieIdModelFromJson(srcJson);

  @override
  bool operator ==(Object other) {
    if (other is NewestCookieIdModel) {
      return cookieId == other.cookieId &&
          updateCookieId == other.updateCookieId;
    }
    return false;
  }
}
