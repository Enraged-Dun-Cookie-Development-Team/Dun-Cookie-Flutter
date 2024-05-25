import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'bakery_data.g.dart';

/// id : "17"
/// description : ""
/// create_time : "2022-04-03T15:13:14.466+00:00"
/// modify_time : "2022-04-04T19:21:54.788+00:00"
/// cvlink : ""
/// fraction : 1
/// daily : [{"datetime":"2022-01-16","info":[{"isTrue":"true","forecast":"<签到服饰>“待晴日”- 深靛"},{"isTrue":"true","forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}],"content":"<p>第一天<font color=\"#fdbf22\">平<i>稳落</i>地</font>，不<b>愧</b>是无敌的<strike>banana</strike>老师</p><p>不负<u>饼学大厦</u>的名号，我们的<span style=\"background-color: rgb(224, 59, 59);\">未来一片光明</span>！（挥拳）<span style=\"font-size: 14px;\">😀</span></p>"},{"datetime":"2022-01-17","info":[{"isTrue":"true","forecast":"<活动异格>五星速射手 -寒芒克洛丝"},{"isTrue":"false","forecast":"“且试箸”- 食铁兽"}],"content":"<p>第二天瞬间垮掉，不愧是笨蛋的banana老师</p><p>有愧饼学大厦的名号，我们的未来一片黑暗！（挥泪）</p>"},{"datetime":"2022-01-18","info":[{"isTrue":"true","forecast":"五星战术家 - 夜半"},{"isTrue":"false","forecast":"【常驻标准寻访预告】"}],"content":"<p>第三天\\n请在此处填写今日感想\\n第一句，第二句</p><p>第三句，第四句！（挥【填写物品名称】）</p><p>（干员按正常顺序发布，轮换池提前一天芭娜娜没想到）</p>"},{"datetime":"2022-01-19","info":[{"isTrue":"true","forecast":"闪断更新公告"},{"isTrue":"true","forecast":" “冷山 月” - 乌有"}],"content":"<p>第四天锟斤拷，不愧是锟斤拷的banana老师</p><p>锟斤拷锟斤拷的名号，我们的未来一片烫烫烫！</p>"},{"datetime":"2022-01-21","info":[{"isTrue":"false","forecast":"“染尘烟” - 夕"}],"content":"<p>芭娜娜今天做出以下锐评：</p><p>“嘿嘿，夕我的夕”</p>"},{"datetime":"2022-01-22","info":[{"isTrue":"true","forecast":"#罗 德岛闲逛部#"},{"isTrue":"true","forecast":"六星行商 - 老鲤"}],"content":"<p>没想到吧其他啥也没有了【抹眼泪】</p>"},{"datetime":"2022-01-23","info":[{"isTrue":"true","forecast":"#罗德岛相簿#"},{"isTrue":"true","forecast":"六星召唤师 - 令 [限定]"},{"isTrue":"true","forecast":"【山城茶馆】主题家具"}],"content":"<p>#明日方舟##饼学大厦#&nbsp;</p><p>世界未解之谜之一被解开了：</p><p>昨天不发饼的原因是</p><p>从暮落开始YJ有意更新干员基建/技能介绍的动图的新样式（每年一次）</p>"},{"datetime":"2022-01-24","info":[],"content":"<p>Sidestory「将进酒」机制 +&nbsp;停机更新公告\\n有可能出现今天没有猜东西，但是最后有结果,就像这样子</p>"},{"datetime":"2022-01-25","info":[{"isTrue":"unknown","forecast":"令EP"},{"isTrue":"unknown","forecast":"Sidestory「将进酒」开启"}],"content":""},{"datetime":"2022-01-26","info":[{"isTrue":"unknown","forecast":"老鲤EP"}],"content":""},{"datetime":"2022-01-30","info":[{"isTrue":"unknown","forecast":"#罗德岛相簿#（可能延后至02.01）"}],"content":""},{"datetime":"2022-02-01","info":[{"isTrue":"unknown","forecast":"春节贺图"}],"content":""}]
BakeryDataModel bakeryDataFromJson(String str) =>
    BakeryDataModel.fromJson(json.decode(str));

String bakeryDataToJson(BakeryDataModel data) => json.encode(data.toJson());

@JsonSerializable()
class BakeryDataModel {
  String id;
  String description;
  String createTime;
  String modifyTime;
  String cvLink;
  int fraction;
  @JsonKey(defaultValue: [])
  List<BakeryDaily> daily;

  BakeryDataModel({
    this.id = "",
    this.description = "",
    this.createTime = "",
    this.modifyTime = "",
    this.cvLink = "",
    this.fraction = 0,
    required this.daily,
  });

  @override
  factory BakeryDataModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryDataModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BakeryDataModelToJson(this);
}

/// id : "17"
/// description : ""
/// daily : {"datetime":"2022-01-16","info":[{"isTrue":"true","forecast":"<签到服饰>“待晴日”- 深靛"},{"isTrue":"true","forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}],"content":"<p>第一天<font color=\"#fdbf22\">平<i>稳落</i>地</font>，不<b>愧</b>是无敌的<strike>banana</strike>老师</p><p>不负<u>饼学大厦</u>的名号，我们的<span style=\"background-color: rgb(224, 59, 59);\">未来一片光明</span>！（挥拳）<span style=\"font-size: 14px;\">😀</span></p>"}
BakeryRecentPredictModel bakeryRecentPredictDataFromJson(String str) =>
    BakeryRecentPredictModel.fromJson(json.decode(str));

String bakeryRecentPredictDataToJson(BakeryRecentPredictModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class BakeryRecentPredictModel {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'daily')
  BakeryDaily daily;

  BakeryRecentPredictModel({
    this.id = "",
    this.description = "",
    required this.daily,
  });

  factory BakeryRecentPredictModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryRecentPredictModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BakeryRecentPredictModelToJson(this);
}

/// datetime : "2022-01-16"
/// info : [{"isTrue":"true","forecast":"<签到服饰>“待晴日”- 深靛"},{"isTrue":"true","forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}]
/// content : "<p>第一天<font color=\"#fdbf22\">平<i>稳落</i>地</font>，不<b>愧</b>是无敌的<strike>banana</strike>老师</p><p>不负<u>饼学大厦</u>的名号，我们的<span style=\"background-color: rgb(224, 59, 59);\">未来一片光明</span>！（挥拳）<span style=\"font-size: 14px;\">😀</span></p>"
BakeryDaily dailyFromJson(String str) => BakeryDaily.fromJson(json.decode(str));

String dailyToJson(BakeryDaily data) => json.encode(data.toJson());

@JsonSerializable()
class BakeryDaily {
  @JsonKey(name: 'datetime')
  String datetime;
  @JsonKey(name: 'info', defaultValue: [])
  List<BakeryInfo> info;
  @JsonKey(name: 'content')
  String content;

  BakeryDaily({
    this.datetime = "",
    this.content = "",
    required this.info,
  });

  factory BakeryDaily.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryDailyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BakeryDailyToJson(this);
}

/// forecastStatus : "true"
/// forecast : "<签到服饰>“待晴日”- 深靛"
BakeryInfo infoFromJson(String str) => BakeryInfo.fromJson(json.decode(str));

String infoToJson(BakeryInfo data) => json.encode(data.toJson());

@JsonSerializable()
class BakeryInfo {
  @JsonKey(name: 'forecastStatus')
  String forecastStatus;
  @JsonKey(name: 'forecast')
  String forecast;

  BakeryInfo({
    this.forecastStatus = "",
    this.forecast = "",
  });

  factory BakeryInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$BakeryInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BakeryInfoToJson(this);
}
