import 'package:date_format/date_format.dart';

class TimeUnit {
  static String timeDiff({required starTime, isShowSecond = false}) {
    var chinaTime = DateTime.parse(starTime);
    var startDate = changeLocalTime(chinaTime);
    startDate = toUtcChinaTime(startDate);
    var endDate = utcChinaNow();
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
    time ??= DateTime.now();
    var _time = changeLocalTime(stringOrDateTimeToDateTime(time));
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
        return '日';
      case 1:
        return '一';
      case 2:
        return '二';
      case 3:
        return '三';
      case 4:
        return '四';
      case 5:
        return '五';
      case 6:
        return '六';
      default:
        return '无效';
    }
  }

  // 获取现在时间转为utc时区的中国时间
  static utcChinaNow() {
    return DateTime.now().toUtc().add(const Duration(hours: 8));
  }

  // 校准接口获取时间为正确的当地时间
  // param: chinaTime 当地时区的中国时间
  static changeLocalTime(chinaTime) {
    // 时区时间偏移量
    var timeOffset = chinaTime.timeZoneOffset;
    var minOffset = timeOffset.inMinutes;
    // 根据偏移量调整时间
    var localTime = chinaTime.add(Duration(minutes: minOffset - 8 * 60));

    return localTime;
  }

  // 将当地时间转为UTC时区的中国时间
  static toUtcChinaTime(localTime) {
    return localTime.toUtc().add(const Duration(hours: 8));
  }

  // 时间戳转本地时间
  static timestampToDate(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // 时间戳转时间格式YYYY-mm-dd
  static timestampFormatYMD(int timestamp) {
    return formatDate(timestampToDate(timestamp), [yyyy, '-', mm, '-', dd]);
  }
  // 时间戳转时间格式YYYY-mm-dd hh:nn:ss
  static timestampFormatYMDHNS(int timestamp) {
    return formatDate(timestampToDate(timestamp), [yyyy, '-', mm, '-', dd, " ", HH, ":", nn, ":", ss]);
  }

  static TimeDiffModel timeDiffUnit(String endTime) {
    var chinaTime = DateTime.parse(endTime);
    var startDate = changeLocalTime(chinaTime);
    startDate = toUtcChinaTime(startDate);
    var endDate = utcChinaNow();
    int inSeconds = startDate.difference(endDate).inSeconds;
    var day = (inSeconds / 86400).floor();
    var hour = (inSeconds / 60 / 60 % 24).floor();
    var minute = (inSeconds / 60 % 60).floor();
    if (inSeconds <= 0) {
      return TimeDiffModel(number: 0, unit: "秒");
    } else if (day > 0) {
      return TimeDiffModel(number: day, unit: "天");
    } else if (hour > 0) {
      return TimeDiffModel(number: hour, unit: "小时");
    } else {
      return TimeDiffModel(number: minute, unit: "分钟");
    }
  }
}

class TimeDiffModel {
  int number;
  String unit;
  TimeDiffModel({
    required this.number,
    required this.unit,
  });
}
