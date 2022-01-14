class TimeUnit {
  static String timeDiff({required starTime, endTime = null}) {
    var startDate = DateTime.parse(starTime);
    var endDate = DateTime.now();
    if (endTime != null) {
      endDate = DateTime.parse(endTime);
    }
    var inSeconds = endDate.difference(startDate).inSeconds;
    var day = (inSeconds / 86400).floor();
    inSeconds = inSeconds - (day * 86400);
    var hour = (inSeconds / 3600).floor();
    var srtHour = hour.toString().length < 2 ? "0$hour" : "$hour";
    inSeconds = inSeconds % 3600;
    var minute = (inSeconds / 60).floor();
    var srtMinute = minute.toString().length < 2 ? "0$minute" : "$minute";
    inSeconds = inSeconds % 60;
    var second = inSeconds;
    var srtSecond = second.toString().length < 2 ? "0$second" : "$second";
    return "$day天$srtHour小时$srtMinute分钟$srtSecond秒";
  }
}
