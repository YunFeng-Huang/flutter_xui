import 'date_util.dart';

class TimeFormat {
  /**
   * 获取某一年的第一个月的第一天和最后一个月的最后一天
   */
  static getStartEndYearDate(int iYear) {
    Map mapDate = new Map();
    int yearNow = DateTime.now().year;
    yearNow = yearNow + iYear;

    String newStartYear = '$yearNow' + '-' + '01' + '-' + '01';
    String newEndtYear = (yearNow + 1).toString() + '-' + '01' + '-' + '00';

    mapDate['startTime'] = DateUtil.formatDate(
        DateTime.fromMillisecondsSinceEpoch(turnTimestamp(newStartYear)),
        format: 'yyyy-MM-dd');
    mapDate['endTime'] = DateUtil.formatDate(
        DateTime.fromMillisecondsSinceEpoch(turnTimestamp(newEndtYear)),
        format: 'yyyy-MM-dd');

    mapDate['startStamp'] = turnTimestamp(mapDate['startTime'] + ' 00:00:00');
    mapDate['endStamp'] = turnTimestamp(mapDate['endTime'] + ' 23:59:59');
    print('某一年初和年末：$mapDate');
  }

  /**
   * 获得当前日期 未来/过去 第某个月第一天和最后一天时间
   */
  static getMonthDate(int iMonth) {
    //获取当前日期
    var currentDate = new DateTime.now();
    if (iMonth + currentDate.month > 0) {
      return timeConversion(
          iMonth + currentDate.month, (currentDate.year).toString());
    } else {
      int beforeYear = (iMonth + currentDate.month) ~/ 12;
      String yearNew = (currentDate.year + beforeYear - 1).toString();
      int monthNew = (iMonth + currentDate.month) - beforeYear * 12;
      return timeConversion(12 + monthNew, yearNew);
    }
  }

  static timeConversion(int monthTime, String yearTime) {
    Map<String, String> dateMap = Map();
    dateMap['startDate'] = '$yearTime' +
        '-' +
        (monthTime < 10 ? '0' + monthTime.toString() : '$monthTime') +
        '-' +
        '01';
    //转时间戳再转时间格式 防止出错
    dateMap['startDate'] = DateUtil.formatDate(
        DateTime.fromMillisecondsSinceEpoch(
            turnTimestamp(dateMap['startDate']!)),
        format: 'yyyy-MM-dd');
    //某个月结束时间，转时间戳再转
    String endMonth = '$yearTime' +
        '-' +
        ((monthTime + 1) < 10
                ? '0' + (monthTime + 1).toString()
                : (monthTime + 1))
            .toString() +
        '-' +
        '00';
    var endMonthTimeStamp = turnTimestamp(endMonth);
    endMonth = DateUtil.formatDate(
        DateTime.fromMillisecondsSinceEpoch(endMonthTimeStamp),
        format: 'yyyy-MM-dd');
    dateMap['endDate'] = endMonth;
    //这里是为了公司后台接口 需加时间段的时间戳 但不显示在格式化实践中
    dateMap['startDateStamp'] =
        turnTimestamp(dateMap['startDate']! + ' 00:00:00').toString();
    dateMap['endDateStamp'] =
        turnTimestamp(dateMap['endDate']! + ' 23:59:59').toString();
    print('过去未来某个月初月末：$dateMap');
    return dateMap;
  }

  /**
   * 转时间戳
   */
  static int turnTimestamp(String timestamp) {
    return DateTime.parse(timestamp).millisecondsSinceEpoch;
  }

  /**
   * 当前时间 过去/未来 某个周的周一和周日
   */
  static getWeeksDate(int weeks) {
    Map<String, String> mapTime = new Map();
    DateTime now = new DateTime.now();
    int weekday = now.weekday; //今天周几

    var sunDay = getTimestampLatest(false, 7 - weekday + weeks * 7); //周末
    var monDay = getTimestampLatest(true, -weekday + 1 + weeks * 7); //周一

    mapTime['monDay'] = DateUtil.formatDate(
        DateTime.fromMillisecondsSinceEpoch(sunDay),
        format: 'yyyy-MM-dd'); //周一 时间格式化
    mapTime['sunDay'] = DateUtil.formatDate(
        DateTime.fromMillisecondsSinceEpoch(monDay),
        format: 'yyyy-MM-dd'); //周一 时间格式化
    mapTime['monDayStamp'] = '$monDay'; //周一 时间戳
    mapTime['sunDayStamp'] = '$sunDay'; //周日 时间戳
    print('某个周的周一和周日：$mapTime');
    return mapTime;
  }

  /**
   * phase : 是零点还是23:59:59
   */
  static int getTimestampLatest(bool phase, int day) {
    String newHours;
    DateTime now = new DateTime.now();
    DateTime sixtyDaysFromNow = now.add(new Duration(days: day));
    String formattedDate =
        DateUtil.formatDate(sixtyDaysFromNow, format: 'yyyy-MM-dd');
    if (phase) {
      newHours = formattedDate + ' 00:00:00';
    } else {
      newHours = formattedDate + ' 23:59:59';
    }

    DateTime newDate = DateTime.parse(newHours);
    String newFormattedDate =
        DateUtil.formatDate(newDate, format: 'yyyy-MM-dd HH:mm:ss');
    int timeStamp = newDate.millisecondsSinceEpoch;
    // print('时间' + newFormattedDate);
    return timeStamp;
  }
}
