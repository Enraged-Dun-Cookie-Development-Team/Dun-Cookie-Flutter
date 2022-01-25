import 'dart:convert';

/// title : "1.23小寄怡情·饼学大厦#16(ver.辞旧迎新纪念活动)"
/// createTime : "2022-01-13"
/// updateTime : "2022-01-24"
/// fraction : 4
/// day : [{"datetime":"2022-01-16","info":[{"isTrue":true,"forecast":"<签到服饰> “待晴日” - 深靛 "},{"isTrue":true,"forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}],"content":"第一天平稳落地，不愧是无敌的banana老师\n不负饼学大厦的名号，我们的未来一片光明！（挥拳）"},{"datetime":"2022-01-17","info":[{"isTrue":true,"forecast":"<活动异格>五星速射手 - 寒芒克洛丝"},{"isTrue":false,"forecast":"“且试箸” - 食铁兽"}],"content":"第二天瞬间垮掉，不愧是笨蛋的banana老师\n有愧饼学大厦的名号，我们的未来一片黑暗！（挥泪）"},{"datetime":"2022-01-18","info":[{"isTrue":true,"forecast":"五星战术家 - 夜半"},{"isTrue":false,"forecast":"【常驻标准寻访预告】"}],"content":"第三天\n请在此处填写今日感想\n第一句，第二句\n第三句，第四句！（挥【填写物品名称】）\n（干员按正常顺序发布，轮换池提前一天芭娜娜没想到）"},{"datetime":"2022-01-19","info":[{"isTrue":true,"forecast":"闪断更新公告"},{"isTrue":true,"forecast":" “冷山月” - 乌有"}],"content":"第四天锟斤拷，不愧是锟斤拷的banana老师\n锟斤拷锟斤拷的名号，我们的未来一片烫烫烫！"},{"datetime":"2022-01-18","info":[{"isTrue":false,"forecast":"“染尘烟” - 夕"}],"content":"芭娜娜今天做出以下锐评：\n“嘿嘿，夕我的夕”"},{"datetime":"2022-01-22","info":[{"isTrue":true,"forecast":"#罗德岛闲逛部#"},{"isTrue":true,"forecast":"六星行商 - 老鲤"}],"content":"没想到吧其他啥也没有了【抹眼泪】"},{"datetime":"2022-01-23","info":[{"isTrue":true,"forecast":" #罗德岛相簿#"},{"isTrue":true,"forecast":" 六星召唤师  - 令 [限定]"},{"isTrue":true,"forecast":" 【山城茶馆】主题家具"}],"content":"#明日方舟##饼学大厦# \n世界未解之谜之一被解开了：\n昨天不发饼的原因是\n从暮落开始YJ有意更新干员基建/技能介绍的动图的新样式（每年一次）"},{"datetime":"2022-01-24","info":[],"content":"Sidestory「将进酒」机制 + 停机更新公告\n有可能出现今天没有猜东西，但是最后有结果,就像这样子"},{"datetime":"2022-01-25","info":[{"forecast":" 令EP"},{"forecast":" Sidestory「将进酒」开启"}],"content":""},{"datetime":"2022-01-26","info":[{"forecast":" 老鲤EP"}],"content":""},{"datetime":"2022-01-30","info":[{"forecast":" #罗德岛相簿#（可能延后至02.01）"}],"content":""},{"datetime":"2022-02-01","info":[{"forecast":"春节贺图"}],"content":""}]

BakeryData bakeryDataFromJson(String str) =>
    BakeryData.fromJson(json.decode(str));

String bakeryDataToJson(BakeryData data) => json.encode(data.toJson());

class BakeryData {
  BakeryData({
    this.title,
    this.createTime,
    this.updateTime,
    this.fraction,
    this.day,
  });

  BakeryData.fromJson(dynamic json) {
    title = json['title'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    fraction = json['fraction'];
    if (json['day'] != null) {
      day = [];
      json['day'].forEach((v) {
        day?.add(BakeryDay.fromJson(v));
      });
    }
  }

  String? title;
  String? createTime;
  String? updateTime;
  int? fraction;
  List<BakeryDay>? day;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    map['fraction'] = fraction;
    if (day != null) {
      map['day'] = day?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// datetime : "2022-01-16"
/// info : [{"isTrue":true,"forecast":"<签到服饰> “待晴日” - 深靛 "},{"isTrue":true,"forecast":"<签到家具>“ 山中弈 ”&“ 亭上雪"}]
/// content : "第一天平稳落地，不愧是无敌的banana老师\n不负饼学大厦的名号，我们的未来一片光明！（挥拳）"

BakeryDay dayFromJson(String str) => BakeryDay.fromJson(json.decode(str));

String dayToJson(BakeryDay data) => json.encode(data.toJson());

class BakeryDay {
  BakeryDay({
    this.datetime,
    this.info,
    this.content,
  });

  BakeryDay.fromJson(dynamic json) {
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

/// isTrue : true
/// forecast : "<签到服饰> “待晴日” - 深靛 "

BakeryInfo infoFromJson(String str) => BakeryInfo.fromJson(json.decode(str));

String infoToJson(BakeryInfo data) => json.encode(data.toJson());

class BakeryInfo {
  BakeryInfo({
    this.isTrue,
    this.forecast,
  });

  BakeryInfo.fromJson(dynamic json) {
    isTrue = json['isTrue'];
    forecast = json['forecast'];
  }

  bool? isTrue;
  String? forecast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isTrue'] = isTrue;
    map['forecast'] = forecast;
    return map;
  }
}
