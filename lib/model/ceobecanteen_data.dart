import 'dart:convert';

import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/page/main/more/ui/tool_link.dart';
import 'package:flutter/cupertino.dart';

import '../request/tool/tools_request.dart';

/// main : [{"html":"<div class='online-area'> <img class='online-title-img radius' src='https://ak.hycdn.cn/announce/images/20220107/77147ef49ee9d0d0822e0267a4ecd001.jpg'> <div> <div><span class='online-blue'>《明日方舟》2022年春节前瞻特辑</span></div> <div>将于<span class='online-blue'>01月15日20:00</span>进行直播</div> <div>将介绍<span class='online-yellow'>春节相关活动</span>，<span class='online-yellow'>全新SideStory</span></div> <div>以及<span class='online-yellow'>后续版本计划</span>等内容为主</div> 点击 <a class='webOpen' href='https://live.bilibili.com/5555734'><span class='online-red'>这里</span></a> 快速跳转直播界面</div> </div> </div>","starTime":"2022-01-11 04:00:00","overTime":"2022-01-14 03:59:59","notice":false},{"html":"<div class='online-area'> <img class='online-title-img radius' src='https://ak.hycdn.cn/announce/images/20220107/77147ef49ee9d0d0822e0267a4ecd001.jpg'> <div> <div><span class='online-blue'>《明日方舟》2022年春节前瞻特辑</span></div> <div>将于<span class='online-blue'>01月15日20:00</span>进行直播</div> <div>将介绍<span class='online-yellow'>春节相关活动</span>，<span class='online-yellow'>全新SideStory</span></div> <div>以及<span class='online-yellow'>后续版本计划</span>等内容为主</div> 点击 <a class='webOpen' href='https://live.bilibili.com/5555734'><span class='online-red'>这里</span></a> 快速跳转直播界面</div> </div> </div>","starTime":"2022-01-14 04:00:00","overTime":"2022-01-15 20:59:59","notice":true},{"html":"<div class='online-area'> <img class='online-title-img radius' src='https://ak.hycdn.cn/announce/images/20211207/9c3fc9ff9987949dedcf1f0658b6e020.png'> <div> <div><span class='online-blue'>SideStory「画中人」复刻</span>将于<span class='online-blue'>1月10号</span>开启</div> <div>开启时间为<span class='online-red'>周一16:00</span></div> <div>本次活动掉落<span class='online-red'> 炽合金、聚酸酯组、固源岩组</span></div> <div>活动开启时，<span class='online-yellow'>快捷链接</span>更新<span class='online-blue'>作业视频</span> </div> <div>或者点击 <span class='online-blue'><drawer>这里</drawer></span> 快速跳转</div> </div> </div>","starTime":"2022-01-03 04:00:00","overTime":"2022-01-10 15:59:59","notice":false},{"html":"<div class='online-area'> <img class='online-title-img radius' src='https://ak.hycdn.cn/announce/images/20211207/9c3fc9ff9987949dedcf1f0658b6e020.png'> <div> <div><span class='online-blue'>>SideStory「画中人」复刻</span>将于<span class='online-blue'>1月20号</span>结束</div> <div>本次活动掉落<span class='online-red'> 炽合金、聚酸酯组、固源岩组</span></div> <div>博士们尽情刷材料吧</div> <div>活动开启时，<span class='online-yellow'>快捷链接</span>更新<span class='online-blue'>作业视频</span> </div> <div>或者点击 <span class='online-blue'><drawer>这里</drawer></span> 快速跳转</div> </div> </div>","starTime":"2022-01-10 16:00:00","overTime":"2022-01-20 03:59:59","notice":false},{"html":"<div class='online-area'> <img class='online-title-img radius' src='https://i0.hdslb.com/bfs/album/c65bbe252a3e751664573da3865b0763623b9972.jpg'> <div> <div><span class='online-blue'>方舟拜年纪「流光启明」</span>将于<span class='online-blue'>1月23号晚上18:30</span>开始直播</div> <div>正片放送时间为<span class='online-blue'>当晚23:00</span></div> <div><span class='online-red'>感谢所有二创作者们的付出</span></div> <div>也相信这次流光启明拜年纪会给全体博士带来一个美好的回忆！！！</div> <div>点击 <a class='webOpen online-red' href='https://www.bilibili.com/blackboard/activity-4FXc3HQ2KF.html'><span class='online-red'>这里</span></a> 快速跳转预约界面</div> </div> </div>","starTime":"2022-01-03 16:00:00","overTime":"2022-01-23 22:59:59","notice":false},{"html":"<div class='online-area'> <a class='webOpen' href='http://www.ceobecanteen.top/'><img class='online-title-img' src='/assets/image/icon_NewYear.png'></a> <div> <div>博士，谢谢你使用蹲饼。</div> <div>如果觉得好用的话，希望能去<a class='webOpen' href='https://github.com/Enraged-Dun-Cookie-Development-Team/Dun-Cookie-Vue'>GitHub</a>上点个<span class='online-red'>Star</span>或者</div> <div>去<a class='webOpen' href='https://chrome.google.com/webstore/detail/%E8%B9%B2%E9%A5%BC-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknights-cook/gblmdllhbodefkmimbcjpflhjneagkkd?hl=zh-CN'>Chrome商店</a>，<a class='webOpen' href='https://microsoftedge.microsoft.com/addons/detail/%E5%B0%8F%E5%88%BB%E9%A3%9F%E5%A0%82-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknight/jimmfliacfpeabcifcghmdankmdnmfmn?hl=zh-CN'>Edge商店</a>或<a class='webOpen' href='https://addons.mozilla.org/zh-CN/firefox/addon/%E5%B0%8F%E5%88%BB%E9%A3%9F%E5%A0%82-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknights-cookies/'>Firefox商店</a>里面给个<span class='online-red'>好评</span></div> <div>也可以去<a class='webOpen' href='https://arknightscommunity.drblack-system.com/15386.html'>泰拉通讯枢纽</a>里面<span class='online-red'>回复我们</span>，或者去<a class='webOpen' href='https://www.bilibili.com/video/BV1jv411P7bR/'>b站视频</a>给个<span class='online-red'>三连</span></div> <div>欢迎加群 <a class='webOpen' href='https://jq.qq.com/?_wv=1027&k=Vod1uO13'>【蹲饼测试群】</a> 一起聊天，蹲饼！</div> </div> </div>","starTime":"2021-5-01 12:00:00","overTime":"2099-12-31 04:00:00","notice":false}]
/// btnList : [{"starTime":"2021-12-21 04:00:00","overTime":"2022-01-04 03:59:59","url":"https://www.bilibili.com/video/BV13Z4y1X76g","name":"【魔法Zc目录】“风雪过境”BI平民全关卡低配攻略！阵容平民+低练度+语音详解的愉悦攻略！","img":"https://i0.hdslb.com/bfs/archive/14fec313d3c7a478da6e0c87433132072ceadf5b.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2022-01-11 04:00:00","overTime":"2022-01-18 03:59:59","url":"https://www.bilibili.com/video/BV1RY41187vG","name":"【好吃的橘子鸭/南方监狱】单核打法，无专精，技能最高7级，阵容平民，语音详解！","img":"https://i0.hdslb.com/bfs/archive/78b3f60e2e2c6c6d315b37b7853dc9804c79f74c.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2021-12-21 04:00:00","overTime":"2022-01-04 03:59:59","url":"https://www.bilibili.com/video/BV1AZ4y1X7Yr","name":"【小狼XF】明日方舟BI-全关卡 无6星攻略/BI-8 BI-7 风雪过境","img":"https://i1.hdslb.com/bfs/archive/1c0b4be15c28611b3c96c9da648bf691ef68197b.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2022-01-11 04:00:00","overTime":"2022-01-20 03:59:59","url":"https://www.bilibili.com/video/BV18S4y1j77Z","name":"【萧然Q/画中人】WR-1至WR-EX-8突袭 摆完挂机 简单好抄","img":"https://i0.hdslb.com/bfs/archive/89a1bfb3cc219193c71a7605622d3fa46c8db387.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2022-01-11 04:00:00","overTime":"2022-01-18 03:59:59","url":"https://www.bilibili.com/video/BV18Y41187Tw","name":"【自在道爷】南方监狱挂机流，新剿灭摆完就过！精二31快乐讲解，轻松解放双手 | 剿灭委托400杀","img":"https://i2.hdslb.com/bfs/archive/8c5342d59969edcd6187e4778ec1335724088eb7.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2021-12-21 04:00:00","overTime":"2022-01-04 03:59:59","url":"https://www.bilibili.com/video/BV1Z7411T7cF","name":"【年轻型斯卡哈】风雪过境 自动挂机+少人信赖 全关卡攻略合集","img":"https://i2.hdslb.com/bfs/archive/fa8fba6d749beae7ff1c9f2382c76eeb0343063d.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2021-12-24 04:00:00","overTime":"2022-01-04 15:59:59","url":"https://www.bilibili.com/video/BV19b4y1v7Wa","name":"【杨颜同学】风雪过境录播 全流程剧情+推关","img":"https://i0.hdslb.com/bfs/archive/ad102b8851a3f629bc6bab9596e3b8f9a75d390d.jpg@200w_125h_1c.webp","radius":true},{"starTime":"2022-01-11 04:00:00","overTime":"2022-01-25 03:59:59","url":"https://www.bilibili.com/video/BV17m4y1X7U3","name":"【_碧空残云_】 冰原赞歌 【3D同人动画】","img":"https://i2.hdslb.com/bfs/archive/b6492ff74fe980a9c68c1f7737f8b5de600cb722.jpg@200w_125h.webp","radius":true},{"starTime":"2022-01-11 04:00:00","overTime":"2022-01-25 03:59:59","url":"https://www.bilibili.com/video/BV1dR4y1x7dV","name":"【上帝大哥】我在MC中还原了卡西米尔大骑士领竞技场","img":"https://i1.hdslb.com/bfs/archive/0c18ab3e1944cb599d11c4bac56e88ed37605976.jpg@200w_125h.webp","radius":true},{"starTime":"2022-01-03 04:00:00","overTime":"2022-01-13 15:59:59","url":"https://www.bilibili.com/video/BV1ba411z7NG","name":"【盐鱼料理长】教你做【东方馅挂炒饭】","img":"https://i0.hdslb.com/bfs/archive/8a0da3a7992712807586723e479685739d4a6d7b.jpg@160w_100h.webp","radius":true},{"starTime":"2022-01-03 04:00:00","overTime":"2022-01-23 22:59:59","url":"https://www.bilibili.com/blackboard/activity-4FXc3HQ2KF.html","name":"【明日方舟拜年纪】流光启明预约界面","img":"https://i0.hdslb.com/bfs/album/c65bbe252a3e751664573da3865b0763623b9972.jpg","radius":true}]
/// dayInfo : {"resources":{"starTime":"2021-11-22 16:00:00","overTime":"2021-12-06 03:59:59"},"countdown":[{"text":"当前轮换池结束","remark":"风笛[兑换],煌,幽灵鲨,苇草[兑换],食铁兽","time":"2022-01-20 03:59:59","starTime":"2022-01-06 04:00:00","overTime":"2022-01-20 03:59:59"},{"text":"当前轮换池结束","remark":"莫斯提马[兑换]、银灰、灰喉、月禾[兑换]、星极","time":"2022-01-06 03:59:59","starTime":"2021-12-23 04:00:00","overTime":"2022-01-06 03:59:59"},{"text":"当前跨年欢庆池结束","remark":"第一个六星必为你没有的六星","time":"2022-01-15 03:59:59","starTime":"2022-01-04 04:00:00","overTime":"2022-01-15 03:59:59"},{"text":"下个活动池开启","remark":"灵知，极光，初雪","time":"2021-12-21 15:59:59","starTime":"2021-12-21 04:00:00","overTime":"2021-12-21 15:59:59"},{"text":"当前活动池结束","remark":"灵知，极光，初雪","time":"2022-01-04 03:59:59","starTime":"2021-12-21 16:00:00","overTime":"2022-01-04 03:59:59"},{"text":"SideStory「画中人」，复刻开启","remark":"解锁条件：通关主线1-10","time":"2022-01-10 15:59:59","starTime":"2022-01-05 16:00:00","overTime":"2022-01-10 15:59:59"},{"text":"SideStory「画中人」，复刻结束","remark":"解锁条件：通关主线1-10","time":"2022-01-20 03:59:59","starTime":"2022-01-10 16:00:00","overTime":"2022-01-20 03:59:59"},{"text":"【集成战略】常驻系统，上线开启","remark":"","time":"2022-01-05 15:59:59","starTime":"2022-01-04 03:59:59","overTime":"2022-01-05 15:59:59"}]}
/// logo : "icon_NewYear.png"
/// upgrade : {"v":"3.0.14","title":"小刻食堂翻新啦 - 3.0.14","description":"😭 呜呜呜，跨年导致游戏内通讯组时间错误，熬夜调试加急修复发布 </br>1.修复游戏内通讯组源因为时间错误导致显示在前面","downCrx":"https://github.com/Enraged-Dun-Cookie-Development-Team/Dun-Cookie-Vue/releases/download/3.0.14/Dun-Cookie-3.0.14.crx","downZip":"https://github.com/Enraged-Dun-Cookie-Development-Team/Dun-Cookie-Vue/releases/download/3.0.14/Dun-Cookie-3.0.14.zip","downSpare":"https://pan.baidu.com/s/1kzY6kpfYqLcGpuaiwQOGoA","downSpareText":"备用下载（提取码 jzq9）","downChrome":"https://chrome.google.com/webstore/detail/%E8%B9%B2%E9%A5%BC-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknights-cook/gblmdllhbodefkmimbcjpflhjneagkkd?hl=zh-CN","downEdge":"https://microsoftedge.microsoft.com/addons/detail/%E5%B0%8F%E5%88%BB%E9%A3%9F%E5%A0%82-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknight/jimmfliacfpeabcifcghmdankmdnmfmn?hl=zh-CN","downFirefox":"https://addons.mozilla.org/zh-CN/firefox/addon/%E5%B0%8F%E5%88%BB%E9%A3%9F%E5%A0%82-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknights-cookies/"}
/// insider : {"f6e9fa6d782cfb7781cee67c0a188637d44ef761af74e0bfff02e1f53786b90e78fcbe3bb31a602f405c37491fc6fb7b5f8dd4df0e76132f8886a6b7846dfa6b":1,"71add0d3edb7f188abf850643eeeca13b5cc266254b4d6bf1369e9889c584f658a21f6e110a509d5775c406b022839613196dc16db07677626208c2f5e4f77cc":2}
/// testVersion : 2
/// testUpdate : true
/// testNotUpdate : false

class CeobecanteenData with ChangeNotifier {
  CeobecanteenData(
      {this.list, this.btnList, this.dayInfo, this.logo, this.upgrade}) {
    sourceInfo = SourceList.sourceList;
  }

  CeobecanteenData.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(AnnouncementList.fromJson(v));
      });
    }
    if (json['btnList'] != null) {
      btnList = [];
      json['btnList'].forEach((v) {
        btnList?.add(BtnList.fromJson(v));
      });
    }
    dayInfo =
        json['dayInfo'] != null ? DayInfo.fromJson(json['dayInfo']) : null;
    logo = json['logo'];
    upgrade =
        json['upgrade'] != null ? Upgrade.fromJson(json['upgrade']) : null;
  }

  List<AnnouncementList>? list;
  List<BtnList>? btnList;
  List<SourceInfo>? sourceInfo;
  DayInfo? dayInfo;
  String? logo;
  Upgrade? upgrade;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['main'] = list?.map((v) => v.toJson()).toList();
    }
    if (btnList != null) {
      map['btnList'] = btnList?.map((v) => v.toJson()).toList();
    }
    if (dayInfo != null) {
      map['dayInfo'] = dayInfo?.toJson();
    }
    map['logo'] = logo;
    if (upgrade != null) {
      map['upgrade'] = upgrade?.toJson();
    }
    return map;
  }
}

/// v : "3.0.14"
/// title : "小刻食堂翻新啦 - 3.0.14"
/// description : "😭 呜呜呜，跨年导致游戏内通讯组时间错误，熬夜调试加急修复发布 </br>1.修复游戏内通讯组源因为时间错误导致显示在前面"
/// downCrx : "https://github.com/Enraged-Dun-Cookie-Development-Team/Dun-Cookie-Vue/releases/download/3.0.14/Dun-Cookie-3.0.14.crx"
/// downZip : "https://github.com/Enraged-Dun-Cookie-Development-Team/Dun-Cookie-Vue/releases/download/3.0.14/Dun-Cookie-3.0.14.zip"
/// downSpare : "https://pan.baidu.com/s/1kzY6kpfYqLcGpuaiwQOGoA"
/// downSpareText : "备用下载（提取码 jzq9）"
/// downChrome : "https://chrome.google.com/webstore/detail/%E8%B9%B2%E9%A5%BC-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknights-cook/gblmdllhbodefkmimbcjpflhjneagkkd?hl=zh-CN"
/// downEdge : "https://microsoftedge.microsoft.com/addons/detail/%E5%B0%8F%E5%88%BB%E9%A3%9F%E5%A0%82-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknight/jimmfliacfpeabcifcghmdankmdnmfmn?hl=zh-CN"
/// downFirefox : "https://addons.mozilla.org/zh-CN/firefox/addon/%E5%B0%8F%E5%88%BB%E9%A3%9F%E5%A0%82-%E6%98%8E%E6%97%A5%E6%96%B9%E8%88%9F%E8%B9%B2%E9%A5%BC%E5%99%A8-arknights-cookies/"

Upgrade upgradeFromJson(String str) => Upgrade.fromJson(json.decode(str));

String upgradeToJson(Upgrade data) => json.encode(data.toJson());

class Upgrade {
  Upgrade({
    this.v,
    this.title,
    this.description,
    this.downCrx,
    this.downZip,
    this.downSpare,
    this.downSpareText,
    this.downChrome,
    this.downEdge,
    this.downFirefox,
  });

  Upgrade.fromJson(dynamic json) {
    v = json['v'];
    title = json['title'];
    description = json['description'];
    downCrx = json['downCrx'];
    downZip = json['downZip'];
    downSpare = json['downSpare'];
    downSpareText = json['downSpareText'];
    downChrome = json['downChrome'];
    downEdge = json['downEdge'];
    downFirefox = json['downFirefox'];
  }

  String? v;
  String? title;
  String? description;
  String? downCrx;
  String? downZip;
  String? downSpare;
  String? downSpareText;
  String? downChrome;
  String? downEdge;
  String? downFirefox;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['v'] = v;
    map['title'] = title;
    map['description'] = description;
    map['downCrx'] = downCrx;
    map['downZip'] = downZip;
    map['downSpare'] = downSpare;
    map['downSpareText'] = downSpareText;
    map['downChrome'] = downChrome;
    map['downEdge'] = downEdge;
    map['downFirefox'] = downFirefox;
    return map;
  }
}

/// resources : {"starTime":"2021-11-22 16:00:00","overTime":"2021-12-06 03:59:59"}
/// countdown : [{"text":"当前轮换池结束","remark":"风笛[兑换],煌,幽灵鲨,苇草[兑换],食铁兽","time":"2022-01-20 03:59:59","starTime":"2022-01-06 04:00:00","overTime":"2022-01-20 03:59:59"},{"text":"当前轮换池结束","remark":"莫斯提马[兑换]、银灰、灰喉、月禾[兑换]、星极","time":"2022-01-06 03:59:59","starTime":"2021-12-23 04:00:00","overTime":"2022-01-06 03:59:59"},{"text":"当前跨年欢庆池结束","remark":"第一个六星必为你没有的六星","time":"2022-01-15 03:59:59","starTime":"2022-01-04 04:00:00","overTime":"2022-01-15 03:59:59"},{"text":"下个活动池开启","remark":"灵知，极光，初雪","time":"2021-12-21 15:59:59","starTime":"2021-12-21 04:00:00","overTime":"2021-12-21 15:59:59"},{"text":"当前活动池结束","remark":"灵知，极光，初雪","time":"2022-01-04 03:59:59","starTime":"2021-12-21 16:00:00","overTime":"2022-01-04 03:59:59"},{"text":"SideStory「画中人」，复刻开启","remark":"解锁条件：通关主线1-10","time":"2022-01-10 15:59:59","starTime":"2022-01-05 16:00:00","overTime":"2022-01-10 15:59:59"},{"text":"SideStory「画中人」，复刻结束","remark":"解锁条件：通关主线1-10","time":"2022-01-20 03:59:59","starTime":"2022-01-10 16:00:00","overTime":"2022-01-20 03:59:59"},{"text":"【集成战略】常驻系统，上线开启","remark":"","time":"2022-01-05 15:59:59","starTime":"2022-01-04 03:59:59","overTime":"2022-01-05 15:59:59"}]

DayInfo dayInfoFromJson(String str) => DayInfo.fromJson(json.decode(str));

String dayInfoToJson(DayInfo data) => json.encode(data.toJson());

class DayInfo {
  DayInfo({
    this.resources,
    this.countdown,
  });

  DayInfo.fromJson(dynamic json) {
    resources = json['resources'] != null
        ? Resources.fromJson(json['resources'])
        : null;
    if (json['countdown'] != null) {
      countdown = [];
      json['countdown'].forEach((v) {
        countdown?.add(Countdown.fromJson(v));
      });
    }
  }

  Resources? resources;
  List<Countdown>? countdown;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (resources != null) {
      map['resources'] = resources?.toJson();
    }
    if (countdown != null) {
      map['countdown'] = countdown?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "当前轮换池结束"
/// remark : "风笛[兑换],煌,幽灵鲨,苇草[兑换],食铁兽"
/// time : "2022-01-20 03:59:59"
/// starTime : "2022-01-06 04:00:00"
/// overTime : "2022-01-20 03:59:59"

Countdown countdownFromJson(String str) => Countdown.fromJson(json.decode(str));

String countdownToJson(Countdown data) => json.encode(data.toJson());

class Countdown {
  Countdown({
    this.text,
    this.remark,
    this.time,
    this.starTime,
    this.overTime,
  });

  Countdown.fromJson(dynamic json) {
    text = json['text'];
    remark = json['remark'];
    time = json['time'];
    starTime = json['starTime'];
    overTime = json['overTime'];
  }

  String? text;
  String? remark;
  String? time;
  String? starTime;
  String? overTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['remark'] = remark;
    map['time'] = time;
    map['starTime'] = starTime;
    map['overTime'] = overTime;
    return map;
  }
}

/// starTime : "2021-11-22 16:00:00"
/// overTime : "2021-12-06 03:59:59"

Resources resourcesFromJson(String str) => Resources.fromJson(json.decode(str));

String resourcesToJson(Resources data) => json.encode(data.toJson());

class Resources {
  Resources({
    this.starTime,
    this.overTime,
  });

  Resources.fromJson(dynamic json) {
    starTime = json['starTime'];
    overTime = json['overTime'];
  }

  String? starTime;
  String? overTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['starTime'] = starTime;
    map['overTime'] = overTime;
    return map;
  }
}

/// starTime : "2021-12-21 04:00:00"
/// overTime : "2022-01-04 03:59:59"
/// url : "https://www.bilibili.com/video/BV13Z4y1X76g"
/// name : "【魔法Zc目录】“风雪过境”BI平民全关卡低配攻略！阵容平民+低练度+语音详解的愉悦攻略！"
/// img : "https://i0.hdslb.com/bfs/archive/14fec313d3c7a478da6e0c87433132072ceadf5b.jpg@200w_125h_1c.webp"
/// radius : true

BtnList btnListFromJson(String str) => BtnList.fromJson(json.decode(str));

String btnListToJson(BtnList data) => json.encode(data.toJson());

class BtnList {
  BtnList({
    this.starTime,
    this.overTime,
    this.url,
    this.name,
    this.img,
    this.radius,
  });

  BtnList.fromJson(dynamic json) {
    starTime = json['starTime'];
    overTime = json['overTime'];
    url = json['url'];
    name = json['name'];
    img = json['img'];
    radius = json['radius'];
  }

  String? starTime;
  String? overTime;
  String? url;
  String? name;
  String? img;
  bool? radius;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['starTime'] = starTime;
    map['overTime'] = overTime;
    map['url'] = url;
    map['name'] = name;
    map['img'] = img;
    map['radius'] = radius;
    return map;
  }
}

/// html : "<div class='online-area'> <img class='online-title-img radius' src='https://ak.hycdn.cn/announce/images/20220107/77147ef49ee9d0d0822e0267a4ecd001.jpg'> <div> <div><span class='online-blue'>《明日方舟》2022年春节前瞻特辑</span></div> <div>将于<span class='online-blue'>01月15日20:00</span>进行直播</div> <div>将介绍<span class='online-yellow'>春节相关活动</span>，<span class='online-yellow'>全新SideStory</span></div> <div>以及<span class='online-yellow'>后续版本计划</span>等内容为主</div> 点击 <a class='webOpen' href='https://live.bilibili.com/5555734'><span class='online-red'>这里</span></a> 快速跳转直播界面</div> </div> </div>"
/// starTime : "2022-01-11 04:00:00"
/// overTime : "2022-01-14 03:59:59"
/// notice : false

AnnouncementList listFromJson(String str) =>
    AnnouncementList.fromJson(json.decode(str));

String listToJson(AnnouncementList data) => json.encode(data.toJson());

class AnnouncementList {
  AnnouncementList({
    this.html = "",
    this.starTime,
    this.overTime,
    this.notice,
  });

  AnnouncementList.fromJson(dynamic json) {
    html = json['html'];
    starTime = json['starTime'];
    overTime = json['overTime'];
    notice = json['notice'];
  }

  late String html;
  String? starTime;
  String? overTime;
  bool? notice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['html'] = html;
    map['starTime'] = starTime;
    map['overTime'] = overTime;
    map['notice'] = notice;
    return map;
  }
}

class QuickJump {
  late String url;
  late String name;
  late String img;

  QuickJump(this.url, this.name, this.img);

  QuickJump.fromJson(dynamic json) {
    url = json['jump_url'];
    name = json['nickname'];
    img = json['avatar'];
  }
}

class DunApp {
  DunApp({
    this.lastForceVersion,
    this.force = false,
    this.version,
    this.description,
    this.apk,
    this.spare_apk,
    this.baidu,
  });

  DunApp.fromJson(dynamic json) {
    lastForceVersion = json['last_force_version'];
    force = json['force'];
    version = json['version'];
    description = json['description'];
    apk = json['apk'];
    spare_apk = json["spare_apk"];
    baidu = json["baidu"];
  }

  String? lastForceVersion;
  bool force = false;
  String? version;
  String? description;
  String? apk;
  String? spare_apk;
  String? baidu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['last_force_version'] = lastForceVersion;
    map['force'] = force;
    map['version'] = version;
    map['description'] = description;
    return map;
  }
}
