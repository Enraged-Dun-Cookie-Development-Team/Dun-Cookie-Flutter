import 'dart:convert';

/// checkSource : ["0","1"]
/// isPreview : false
/// shortcutList : ["12345","12345"]

SettingData settingDataFromJson(String str) =>
    SettingData.fromJson(json.decode(str));

String settingDataToJson(SettingData data) => json.encode(data.toJson());

class SettingData {
  SettingData(
      {this.checkSource, this.isPreview, this.shortcutList, this.notOnce});

  SettingData.fromJson(dynamic json) {
    checkSource =
        json['checkSource'] != null ? json['checkSource'].cast<String>() : [];
    isPreview = json['isPreview'];
    notOnce = json['notOnce'];
    shortcutList =
        json['shortcutList'] != null ? json['shortcutList'].cast<String>() : [];
  }

  List<String>? checkSource; // 设定的类别
  bool? isPreview; // 是否为省流 true省流
  bool? notOnce; //  是否为第一次进入(同意软件协议) true第一次（同意）
  List<String>? shortcutList; // 快捷方式

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['checkSource'] = checkSource;
    map['isPreview'] = isPreview;
    map['shortcutList'] = shortcutList;
    map['notOnce'] = notOnce;
    return map;
  }
}
