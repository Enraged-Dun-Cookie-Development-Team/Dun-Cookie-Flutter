/// resources : {"start_time":"2021-11-22 16:00:00","over_time":"2021-12-06 03:59:59"}
/// countdown : [{"text":"当前轮换池结束","remark":"刻俄柏[兑换],水月,赤冬,莱恩哈特[ 兑换],安哲拉","time":"2022-02-17 03:59:59","start_time":"2022-02-03 04:00:00","over_time":"2022-02-17 03:59:59"},{"text":"当前轮换池结束","remark":"棘刺[兑换]、艾雅法拉、乌有、诗怀雅[兑换]、雷蛇","time":"2022-02-03 03:59:59","start_time":"2022-01-20 04:00:00","over_time":"2022-02-03 03:59:59"},{"text":"下个活动池开启","remark":"令[限定]，老鲤，夜半","time":"2022-01-14 15:59:59","start_time":"2022-01-14 04:00:00","over_time":"2022-01-14 15:59:59"},{"text":"下个活动池开启","remark":"令[限定]，老鲤，夜半","time":"2022-01-25 15:59:59","start_time":"2022-01-15 04:00:00","over_time":"2022-01-25 15:59:59"},{"text":"当前活动池结束","remark":"令[限定]，老鲤，夜半","time":"2022-02-08 03:59:59","start_time":"2022-01-25 16:00:00","over_time":"2022-02-08 03:59:59"},{"text":"SideStory「将进酒」，活动开启","remark":"解锁条件：通关主线1-10","time":"2022-01-25 15:59:59","start_time":"2022-01-20 04:00:00","over_time":"2022-01-25 15:59:59"},{"text":"SideStory「画中人」，复刻结束","remark":"解锁条件：通关主线1-10","time":"2022-01-20 03:59:59","start_time":"2022-01-10 16:00:00","over_time":"2022-01-20 03:59:59"},{"text":"SideStory「将进酒」，活动结束","remark":"通关主线1-10","time":"2022-02-08 03:59:59","start_time":"2022-01-25 16:00:00","over_time":"2022-02-08 03:59:59"}]
/// 常用工具-顶部资源信息
class ResourceInfo {
  ResourceInfo({
    Resources? resources,
    List<Countdown>? countdown,
  }) {
    _resources = resources;
    _countdown = countdown;
  }

  ResourceInfo.fromJson(dynamic json) {
    _resources = json['resources'] != null
        ? Resources.fromJson(json['resources'])
        : null;
    if (json['countdown'] != null) {
      _countdown = [];
      json['countdown'].forEach((v) {
        _countdown?.add(Countdown.fromJson(v));
      });
    }
  }
  Resources? _resources;
  List<Countdown>? _countdown;
  ResourceInfo copyWith({
    Resources? resources,
    List<Countdown>? countdown,
  }) =>
      ResourceInfo(
        resources: resources ?? _resources,
        countdown: countdown ?? _countdown,
      );
  Resources? get resources => _resources;
  List<Countdown>? get countdown => _countdown;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_resources != null) {
      map['resources'] = _resources?.toJson();
    }
    if (_countdown != null) {
      map['countdown'] = _countdown?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// text : "当前轮换池结束"
/// remark : "刻俄柏[兑换],水月,赤冬,莱恩哈特[ 兑换],安哲拉"
/// time : "2022-02-17 03:59:59"
/// start_time : "2022-02-03 04:00:00"
/// over_time : "2022-02-17 03:59:59"
/// countdown_type : "banner"
class Countdown {
  Countdown({
    String? text,
    String? remark,
    String? time,
    String? startTime,
    String? overTime,
    String? countdownType,
  }) {
    _text = text;
    _remark = remark;
    _time = time;
    _startTime = startTime;
    _overTime = overTime;
    _countdownType = countdownType;
  }

  Countdown.fromJson(dynamic json) {
    _text = json['text'];
    _remark = json['remark'];
    _time = json['time'];
    _startTime = json['start_time'];
    _overTime = json['over_time'];
    _countdownType = json['countdown_type'];
  }
  String? _text;
  String? _remark;
  String? _time;
  String? _startTime;
  String? _overTime;
  String? _countdownType;
  Countdown copyWith({
    String? text,
    String? remark,
    String? time,
    String? startTime,
    String? overTime,
    String? countdownType,
  }) =>
      Countdown(
        text: text ?? _text,
        remark: remark ?? _remark,
        time: time ?? _time,
        startTime: startTime ?? _startTime,
        overTime: overTime ?? _overTime,
        countdownType: countdownType ?? _countdownType,
      );
  String? get text => _text;
  String? get remark => _remark;
  String? get time => _time;
  String? get startTime => _startTime;
  String? get overTime => _overTime;
  String? get countdownType => _countdownType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['remark'] = _remark;
    map['time'] = _time;
    map['start_time'] = _startTime;
    map['over_time'] = _overTime;
    map['countdown_type'] = _countdownType;
    return map;
  }
}

/// start_time : "2021-11-22 16:00:00"
/// over_time : "2021-12-06 03:59:59"

class Resources {
  Resources({
    String? startTime,
    String? overTime,
  }) {
    _startTime = startTime;
    _overTime = overTime;
  }

  Resources.fromJson(dynamic json) {
    _startTime = json['start_time'];
    _overTime = json['over_time'];
  }
  String? _startTime;
  String? _overTime;
  Resources copyWith({
    String? startTime,
    String? overTime,
  }) =>
      Resources(
        startTime: startTime ?? _startTime,
        overTime: overTime ?? _overTime,
      );
  String? get startTime => _startTime;
  String? get overTime => _overTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_time'] = _startTime;
    map['over_time'] = _overTime;
    return map;
  }
}
