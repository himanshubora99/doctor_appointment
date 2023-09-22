import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static DateTime get currentDateTime => DateTime.now();

  static TimeOfDay get currentTime => TimeOfDay.now();

  static final DateFormat ymdDateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat ymdDateFormatWithTime =
      DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat dmyDateFormat = DateFormat('dd-MM-yyyy');
  static final DateFormat dMonthNameYDateFormat = DateFormat('dd-MMM-yyyy');
  static final DateFormat dMonthNameFormat = DateFormat('dd-MMM');
  static final DateFormat weekDay = DateFormat('EEEE');

  static String? removeTAndZFromISODateTime(String? toIso8601String) {
    String dateTimeString = toIso8601String!;
    if (dateTimeString.contains('T')) {
      dateTimeString = dateTimeString.replaceAll('T', ' ');
    }
    if (dateTimeString.contains('Z')) {
      dateTimeString = dateTimeString.replaceAll('Z', '');
    }
    return dateTimeString;
  }

  static TimeOfDay changeDateTimeIntoTimeOfDay(DateTime dt) {
    return TimeOfDay.fromDateTime(dt);
  }

  static DateTime getFormattedDate(String dtStr) {
    return DateTime.parse(dtStr);
  }

  static DateTime changeTimeOfDayIntoDateTime(
      TimeOfDay? td, DateTime? dateTime) {
    return DateTime(
        dateTime!.year, dateTime.month, dateTime.day, td!.hour, td.minute);
  }

  static String getWeekDay({DateTime? dateTime}) {
    final DateTime dT = dateTime ?? currentDateTime;
    return weekDay.format(dT);
  }

  static String getWeekDayInShort({DateTime? dateTime}) {
    final DateTime dT = dateTime ?? currentDateTime;
    return weekDay.format(dT).substring(0, 3);
  }

  static String getCurrentTimeInHourMinute({DateTime? dateTime}) {
    final DateTime dT = dateTime ?? currentDateTime;
    return '${dT.hour}:${dT.minute}';
  }

  static DateTime changeTimeStringIntoDateTime(
      {required String? timeString, DateTime? incomingDateTime}) {
    DateTime? dateTime = incomingDateTime ?? currentDateTime;
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(
        '${dateTime.year}-${dateTime.month}-${dateTime.day} $timeString:00');
  }

  static DateTime changeDateStringIntoDateTime(
      {required String? dateString, DateTime? incomingDateTime}) {
    DateTime? dateTime = incomingDateTime ?? currentDateTime;
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(
        '${dateTime.year}-${dateTime.month}-${dateTime.day} $dateString');
  }

  // Date in YYYY-MM-DD Format
  static String getStringDateFormatYMD(
      {DateTime? dT, bool? isWithTime = false}) {
    return isWithTime!
        ? ymdDateFormatWithTime.format(dT ?? currentDateTime)
        : ymdDateFormat.format(dT ?? currentDateTime);
  }

  static DateTime getDateOnlyFormatYMD({DateTime? dT}) {
    return DateTime.parse(ymdDateFormat.format(dT ?? currentDateTime));
  }

  static DateTime getDateOnlyFormatDMY({DateTime? dT}) {
    return DateTime.parse(dmyDateFormat.format(dT ?? currentDateTime));
  }

  static String getStringDateFormatDMonthNameY({DateTime? dT}) {
    return dMonthNameYDateFormat.format(dT ?? currentDateTime);
  }

  static String getStringDateFormatDateMonth({DateTime? dT}) {
    return dMonthNameFormat.format(dT ?? currentDateTime);
  }

  static List<DateTime> getWeeksForRange(DateTime start, DateTime end) {
    // List<List<DateTime>> result = <List<DateTime>>[];
    DateTime date = start;
    List<DateTime> week = <DateTime>[];
    while (date.difference(end).inDays <= 0) {
      // // start new week on Monday
      // if (date.weekday == 1 && week.isNotEmpty) {
      //   if (kDebugMode) {
      //     print('Date $date is a Monday');
      //   }
      //   result.add(week);
      //   week = <DateTime>[];
      // }
      week.add(date);
      date = date.add(const Duration(days: 1));
    }
    // result.add(week);
    return week;
  }

  static List<TimeOfDay> getTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, int intervalMinutes) {
    List<TimeOfDay> timesList = <TimeOfDay>[];
    TimeOfDay currentTime = startTime;

    while (currentTime.hour < endTime.hour ||
        (currentTime.hour == endTime.hour &&
            currentTime.minute <= endTime.minute)) {
      timesList.add(currentTime);

      // Increment the time by the interval
      int nextHour = currentTime.hour;
      int nextMinute = currentTime.minute + intervalMinutes;

      if (nextMinute >= 60) {
        nextHour += nextMinute ~/ 60;
        nextMinute %= 60;
      }

      currentTime = TimeOfDay(hour: nextHour, minute: nextMinute);
    }

    return timesList;
  }
}
