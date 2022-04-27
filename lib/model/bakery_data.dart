import 'dart:convert';

import 'dart:ffi';

/// id : "17"
/// description : ""
/// create_time : "2022-04-03T15:13:14.466+00:00"
/// modify_time : "2022-04-04T19:21:54.788+00:00"
/// cvlink : ""
/// fraction : 1
/// daily : [{"datetime":"2022-01-16","info":[{"isTrue":"true","forecast":"<签到服饰>“待晴日”- 深靛"},{"isTrue":"true","forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}],"content":"<p>第一天<font color=\"#fdbf22\">平<i>稳落</i>地</font>，不<b>愧</b>是无敌的<strike>banana</strike>老师</p><p>不负<u>饼学大厦</u>的名号，我们的<span style=\"background-color: rgb(224, 59, 59);\">未来一片光明</span>！（挥拳）<span style=\"font-size: 14px;\">😀</span></p>"},{"datetime":"2022-01-17","info":[{"isTrue":"true","forecast":"<活动异格>五星速射手 -寒芒克洛丝"},{"isTrue":"false","forecast":"“且试箸”- 食铁兽"}],"content":"<p>第二天瞬间垮掉，不愧是笨蛋的banana老师</p><p>有愧饼学大厦的名号，我们的未来一片黑暗！（挥泪）</p>"},{"datetime":"2022-01-18","info":[{"isTrue":"true","forecast":"五星战术家 - 夜半"},{"isTrue":"false","forecast":"【常驻标准寻访预告】"}],"content":"<p>第三天\\n请在此处填写今日感想\\n第一句，第二句</p><p>第三句，第四句！（挥【填写物品名称】）</p><p>（干员按正常顺序发布，轮换池提前一天芭娜娜没想到）</p>"},{"datetime":"2022-01-19","info":[{"isTrue":"true","forecast":"闪断更新公告"},{"isTrue":"true","forecast":" “冷山 月” - 乌有"}],"content":"<p>第四天锟斤拷，不愧是锟斤拷的banana老师</p><p>锟斤拷锟斤拷的名号，我们的未来一片烫烫烫！</p>"},{"datetime":"2022-01-21","info":[{"isTrue":"false","forecast":"“染尘烟” - 夕"}],"content":"<p>芭娜娜今天做出以下锐评：</p><p>“嘿嘿，夕我的夕”</p>"},{"datetime":"2022-01-22","info":[{"isTrue":"true","forecast":"#罗 德岛闲逛部#"},{"isTrue":"true","forecast":"六星行商 - 老鲤"}],"content":"<p>没想到吧其他啥也没有了【抹眼泪】</p>"},{"datetime":"2022-01-23","info":[{"isTrue":"true","forecast":"#罗德岛相簿#"},{"isTrue":"true","forecast":"六星召唤师 - 令 [限定]"},{"isTrue":"true","forecast":"【山城茶馆】主题家具"}],"content":"<p>#明日方舟##饼学大厦#&nbsp;</p><p>世界未解之谜之一被解开了：</p><p>昨天不发饼的原因是</p><p>从暮落开始YJ有意更新干员基建/技能介绍的动图的新样式（每年一次）</p>"},{"datetime":"2022-01-24","info":[],"content":"<p>Sidestory「将进酒」机制 +&nbsp;停机更新公告\\n有可能出现今天没有猜东西，但是最后有结果,就像这样子</p>"},{"datetime":"2022-01-25","info":[{"isTrue":"unknown","forecast":"令EP"},{"isTrue":"unknown","forecast":"Sidestory「将进酒」开启"}],"content":""},{"datetime":"2022-01-26","info":[{"isTrue":"unknown","forecast":"老鲤EP"}],"content":""},{"datetime":"2022-01-30","info":[{"isTrue":"unknown","forecast":"#罗德岛相簿#（可能延后至02.01）"}],"content":""},{"datetime":"2022-02-01","info":[{"isTrue":"unknown","forecast":"春节贺图"}],"content":""}]

BakeryData bakeryDataFromJson(String str) =>
    BakeryData.fromJson(json.decode(str));

String bakeryDataToJson(BakeryData data) => json.encode(data.toJson());

class BakeryData {
  BakeryData(
      {this.id,
      this.description,
      this.createTime,
      this.modifyTime,
      this.cvlink,
      this.fraction,
      this.daily,});

  BakeryData.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    createTime = json['createTime'];
    modifyTime = json['modifyTime'];
    cvlink =
        json['cvlink'] == "" ? json['cvlink'] : json['cvlink'].split('cv')[1];
    fraction = json['fraction'];
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily?.add(BakeryDaily.fromJson(v));
      });
    }
  }

  String? id;
  String? description;
  String? createTime;
  String? modifyTime;
  String? cvlink;
  int? fraction;
  List<BakeryDaily>? daily;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    map['create_time'] = createTime;
    map['modify_time'] = modifyTime;
    map['cvlink'] = cvlink == "" ? cvlink : ('cv' + cvlink!);
    map['fraction'] = fraction;
    if (daily != null) {
      map['daily'] = daily?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// datetime : "2022-01-16"
/// info : [{"isTrue":"true","forecast":"<签到服饰>“待晴日”- 深靛"},{"isTrue":"true","forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}]
/// content : "<p>第一天<font color=\"#fdbf22\">平<i>稳落</i>地</font>，不<b>愧</b>是无敌的<strike>banana</strike>老师</p><p>不负<u>饼学大厦</u>的名号，我们的<span style=\"background-color: rgb(224, 59, 59);\">未来一片光明</span>！（挥拳）<span style=\"font-size: 14px;\">😀</span></p>"

BakeryDaily dailyFromJson(String str) => BakeryDaily.fromJson(json.decode(str));

String dailyToJson(BakeryDaily data) => json.encode(data.toJson());

class BakeryDaily {
  BakeryDaily({
    this.datetime,
    this.info,
    this.content,
  });

  BakeryDaily.fromJson(dynamic json) {
    datetime = json['datetime'];
    if (json['info'] != null) {
      info = [];
      json['info'].forEach((v) {
        info?.add(BakeryInfo.fromJson(v));
      });
    }
    content = json['content'];
  }

  String? datetime;
  List<BakeryInfo>? info;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['datetime'] = datetime;
    if (info != null) {
      map['info'] = info?.map((v) => v.toJson()).toList();
    }
    map['content'] = content;
    return map;
  }
}

/// isTrue : "true"
/// forecast : "<签到服饰>“待晴日”- 深靛"

BakeryInfo infoFromJson(String str) => BakeryInfo.fromJson(json.decode(str));

String infoToJson(BakeryInfo data) => json.encode(data.toJson());

class BakeryInfo {
  BakeryInfo({
    this.forecastStatus,
    this.forecast,
  });

  BakeryInfo.fromJson(dynamic json) {
    forecastStatus = json['forecast_status'];
    forecast = json['forecast'];
  }

  String? forecastStatus;
  String? forecast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['forecast_status'] = forecastStatus;
    map['forecast'] = forecast;
    return map;
  }
}
