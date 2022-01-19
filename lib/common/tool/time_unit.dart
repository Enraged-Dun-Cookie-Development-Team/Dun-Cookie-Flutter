import 'dart:ffi';

class TimeUnit {
  static String timeDiff(
      {required starTime, endTime = null, isShowSecond = false}) {
    var startDate = DateTime.parse(starTime);
    var endDate = DateTime.now();
    if (endTime != null) {
      endDate = DateTime.parse(endTime);
    }
    int inSeconds = endDate.difference(startDate).inSeconds.abs();
    var day = (inSeconds / 86400).floor();
    var hour = (inSeconds / 60 / 60 % 24).floor();
    var srtHour = hour.toString().length < 2 ? "0$hour" : "$hour";
    var minute = (inSeconds / 60 % 60).floor();
    var srtMinute = minute.toString().length < 2 ? "0$minute" : "$minute";
    var second = inSeconds % 60;
    var srtSecond = second.toString().length < 2 ? "0$second" : "$second";
    return "${isTimeAfter(startDate, endDate) ? "已过去" : "还剩"}$day天$srtHour小时$srtMinute分钟${isShowSecond ? "$srtSecond秒" : ""}";
  }

// 时间范围判定
  static bool isTimeRange(time, starTime, endTime) {
    var _time = stringOrDateTimeToDateTime(time);
    var _starTime = stringOrDateTimeToDateTime(starTime);
    var _endTime = stringOrDateTimeToDateTime(endTime);
    if (_time.isAfter(_starTime) && _time.isBefore(_endTime)) {
      return true;
    }
    return false;
  }

//  时间大小比较  endTime是否比stearTime大？
  static bool isTimeAfter(starTime, endTime) {
    DateTime _starTime = stringOrDateTimeToDateTime(starTime);
    DateTime _endTime = stringOrDateTimeToDateTime(endTime);

    if (_endTime.isAfter(_starTime)) {
      return true;
    }
    return false;
  }

  // 时间转时间类型
  static DateTime stringOrDateTimeToDateTime(time) {
    late DateTime _time;
    if (time is DateTime) {
      _time = time;
    } else {
      _time = DateTime.parse(time);
    }
    return _time;
  }

  static numberToWeek(x) {
    switch (x) {
      case 7:
        return '周天';
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      default:
        return '无效';
    }
  }
}
