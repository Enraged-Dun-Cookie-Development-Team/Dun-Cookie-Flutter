
/// "cookie_id": "string",
/// "update_cookie_id": "string"
class NewestCookieIdModel {
  NewestCookieIdModel({
      this.cookieId, 
      this.updateCookieId,});

  NewestCookieIdModel.fromJson(dynamic json) {
    cookieId = json['cookie_id'];
    updateCookieId = json['update_cookie_id'];
  }
  String? cookieId;
  String? updateCookieId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cookie_id'] = cookieId;
    map['update_cookie_id'] = updateCookieId;
    return map;
  }

}