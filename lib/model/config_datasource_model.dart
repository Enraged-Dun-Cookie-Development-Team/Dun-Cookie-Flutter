class ConfigDatasourceModel {
  ConfigDatasourceModel({
      this.nickname, 
      this.avatar, 
      this.uniqueId, 
      this.jumpUrl, 
      this.platform,});

  ConfigDatasourceModel.fromJson(dynamic json) {
    nickname = json['nickname'];
    avatar = json['avatar'];
    uniqueId = json['unique_id'];
    jumpUrl = json['jump_url'];
    platform = json['platform'];
  }
  String? nickname;
  String? avatar;
  String? uniqueId;
  String? jumpUrl;
  String? platform;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nickname'] = nickname;
    map['avatar'] = avatar;
    map['unique_id'] = uniqueId;
    map['jump_url'] = jumpUrl;
    map['platform'] = platform;
    return map;
  }
}