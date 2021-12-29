class SourceList {
  static List<Map<String, dynamic>> _sourceList = [];

  static getSourceList() {
    _sourceList = [];
    _sourceList.add(SourceItem.getMap("bili.ico", "官方B站动态", "哔哩哔哩", 0,
        type: "bili", uid: 161775300));
    _sourceList.add(SourceItem.getMap("weibo.png", "官方微博", "微博", 1,
        type: "weibo", uid: 6279793937));
    _sourceList.add(SourceItem.getMap('txz.jpg', '游戏内公告', '通讯组', 2,
        dataUrl:
            'https://ak-conf.hypergryph.com/config/prod/announce_meta/Android/announcement.meta.json'));
    _sourceList.add(SourceItem.getMap("cho3Weibo.jpg", "朝陇山微博", "朝陇山", 3,
        type: "weibo", uid: 6441489862));
    _sourceList.add(SourceItem.getMap("ys3Weibo.jpg", "一拾山微博", "一拾山", 4,
        type: "weibo", uid: 7506039414));
    _sourceList.add(SourceItem.getMap('sr.png', '塞壬唱片官网', '通讯组', 5,
        dataUrl: 'https://monster-siren.hypergryph.com/api/news'));
    _sourceList.add(SourceItem.getMap("tlWeibo.jpg", "泰拉记事社微博", "泰拉记事社微博", 6,
        type: "weibo", uid: 7499841383));
    _sourceList.add(SourceItem.getMap('mrfz.ico', '官网', '通讯组', 7,
        dataUrl: 'https://ak.hypergryph.com/'));
    _sourceList.add(SourceItem.getMap('tl.jpg', '泰拉记事社官网', '泰拉记事社官网', 8,
        dataUrl: 'https://terra-historicus.hypergryph.com/api/comic'));
    _sourceList.add(SourceItem.getMap('sr.png', '塞壬唱片网易云音乐', '网易云音乐', 9,
        dataUrl: 'http://music.163.com/api/artist/albums/32540734'));
    _sourceList.add(SourceItem.getMap("yjwb.jpg", "鹰角网络微博", "鹰角网络微博", 10,
        type: "weibo", uid: 7461423907));
    return _sourceList;
  }
}

class SourceItem {
  late String? icon;
  late String? dataName;
  late String? title;
  late String? dataUrl;
  late String? url;
  late int? priority;
  late int? uid;

  SourceItem(
    this.icon,
    this.dataName,
    this.title,
    this.dataUrl,
    this.url,
    this.priority,
    this.uid,
  );

  static getMap(icon, dataName, title, priority, {dataUrl, uid, type, url}) {
    var sourceItem =
        SourceItem(icon, dataName, title, dataUrl, url, priority, uid);
    if (uid != null && type != null) {
      if (type == "bili") {
        sourceItem.dataUrl = SourceItem.buildBiliUrl(uid);
      } else if (type == "weibo") {
        sourceItem.dataUrl = SourceItem.buildWeiboUrl(uid);
      }
    }
    sourceItem.icon = "assets/sources_logo/$icon";
    return {
      "priority": sourceItem.priority,
      "data": {
        "icon": sourceItem.icon,
        "dataName": sourceItem.dataName,
        "title": sourceItem.title,
        "dataUrl": sourceItem.dataUrl,
        "priority": sourceItem.priority,
        "uid": sourceItem.uid
      }
    };
  }

  static getSourceInfoInDataName(String name) {}

  static buildBiliUrl(uid) {
    return "https://api.vc.bilibili.com/dynamic_svr/v1/dynamic_svr/space_history?host_uid=$uid&offset_dynamic_id=0&need_top=0&platform=web";
  }

  static buildWeiboUrl(uid) {
    return "https://m.weibo.cn/api/container/getIndex?type=uid&value=$uid&containerid=107603$uid";
  }
}
