import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ATLDateTimeFormat {
  ///   It returns date only and takes input as (datetime or date) and formatType like (dmy,mdy,ymd,ydm..)
  ///
  /// [ formatType ] --> [ ymd, ydm, dmy, dym, mdy, dyd ] accept only
  ///
  /// [ dateTime ] --> DateTime starts year only and dateTime length must be 10 and above only
  ///
  /// [ dateTime ] --> [ 2021-11-25 12:17:00.865, 2021-11-25, 25-12-2020, 2021-11-25T00:00:00.000Z,  2021/11/25 12:17:00.865, 2021/11/25, 2021/11/25T00:00:00.000Z ] accept only
  ///
  /// [ dateTime ] --> [ MM-DD-YYYY format ] not acceptable
  ///
  static String? getConvertedDate(String formatType, dynamic dateTime) {
    if (dateTime == null || dateTime == "" || dateTime.toString().trim().length <= 9) {
      return null;
    }
    bool isSlashContains = dateTime.toString().contains("/");
    bool ishyphenContains = dateTime.toString().contains("-");
    if (isSlashContains || ishyphenContains) {
      List dateArray = dateTime.toString().split((isSlashContains) ? "/" : "-");
      if (dateArray[0].length <= 2) {
        dateTime.toString().replaceAll(RegExp(r'/'), '-');
        dateTime = "${dateTime.toString().split("-")[2]}-${dateTime.toString().split("-")[1]}-${dateTime.toString().split("-")[0]}";
      }
    }

    DateTime newDate;
    if (dateTime is DateTime) {
      newDate = dateTime;
    } else {
      if (dateTime is String && dateTime.length >= 11) {
        newDate = DateTime.parse(dateTime);
      } else {
        dateTime = dateTime.toString().replaceAll(RegExp(r'/'), '-');
        newDate = DateTime.parse("$dateTime 10:00:00");
      }
    }

    if (formatType.toUpperCase() == "YMD") {
      return DateFormat("yyyy-MM-dd").format(newDate);
    } else if (formatType.toUpperCase() == "YDM") {
      return DateFormat("yyyy-dd-MM").format(newDate);
    } else if (formatType.toUpperCase() == "DMY") {
      return DateFormat("dd-MM-yyyy").format(newDate);
    } else if (formatType.toUpperCase() == "DYM") {
      return DateFormat("dd-yyyy-MM").format(newDate);
    } else if (formatType.toUpperCase() == "MDY") {
      return DateFormat("MM-dd-yyyy").format(newDate);
    } else if (formatType.toUpperCase() == "MYD") {
      return DateFormat("MM-yyyy-dd").format(newDate);
    } else {
      return DateFormat("dd-MM-yyyy").format(newDate);
    }
  }

  ///   It returns time and takes input as (DateTime or time) and formatType bool (true, false)
  ///   It also used to inter convert time like (12 hrs to 24 hrs ) or (24 hrs to 12 hrs)
  ///
  /// [ is12HoursFormat ] --> [ true, false ]
  ///
  /// [ dateTime ] --> DateTime starts year only and dateTime length must be 10 and above only if full date pass*
  ///
  /// [ dateTime ] --> [ 2021-11-25 12:17:00.865, 2021-11-25, 2021-11-25T00:00:00.000Z, TimeOfDat(22:00), 10:00 am, 10:00 AM, 10:00 pm, 10:00 PM, 23:00, 23:00:00 ] accept only
  ///
  /// [ dateTime ] --> [ 1/1/2020, 1-1-2020 ] not acceptable
  ///
  static String? getConvertedTime(bool is12HoursFormat, dynamic dateTime) {
    if (dateTime == null || dateTime == "" || dateTime.toString().contains("/") || (dateTime.toString().contains("-") && dateTime.toString().length <= 9)) {
      return null;
    }

    DateTime time;

    if (dateTime is DateTime) {
      time = dateTime;
    } else {
      dateTime = dateTime.toString().trim();
      bool isSpaceContains = dateTime.toString().contains(" ");
      bool isTContains = dateTime.toString().contains("T");
      if ((isSpaceContains || isTContains) && !(dateTime.toUpperCase().endsWith("AM") || dateTime.toUpperCase().endsWith("PM"))) {
        time = DateTime.parse(dateTime);
      } else {
        if (dateTime.toUpperCase().endsWith("AM") || dateTime.toUpperCase().endsWith("PM")) {
          bool isAm = dateTime.toUpperCase().endsWith("AM");
          String newAMTime = dateTime.replaceAll(RegExp(r'am'), 'AM');
          String newPMTime = dateTime.replaceAll(RegExp(r'pm'), 'PM');
          time = DateFormat("hh:mm a").parse((isAm) ? newAMTime : newPMTime);
        } else {
          time = DateTime.parse("2020-01-01 $dateTime");
        }
      }
    }

    if (is12HoursFormat) {
      return DateFormat.jm().format(time);
    } else {
      return DateFormat.Hms().format(time);
    }
  }

  ///   It Returns 12 Hours Format And it takes input as TimeOfDate(TimeOfDay(21:00))   Verified**
  static String get12HrsTimeFromTimeOfDate(BuildContext context, TimeOfDay timeOfDay) {
    return timeOfDay.format(context);
  }

  static double getTimeInDouble(TimeOfDay myTime) {
    return myTime.hour + myTime.minute / 60.0;
  }

  ///   This method takes input as format YYYY-MM-DD and 2021-05-05
  static DateTime convertDBDateTODateTimeFormat(String date) {
    DateTime dateTime = DateTime.parse("${date.split("-")[2]}-${date.split("-")[1]}-${date.split("-")[0]} 00:00:00");
    return dateTime;
  }

  ///   This method takes input as format YYYY-MM-DD, HH:MM:SS and 2021-05-05, 21:32:30
  static DateTime convertDBDateTimeTODateTimeFormat(String date, String time) {
    if (date.split("-")[0].length != 4) {
      return DateTime.now();
    }

    if (date.contains("T")) {
      date = date.split("T")[0];
    }

    if (time.toUpperCase().endsWith("AM") || time.toUpperCase().endsWith("PM")) {
      time = getConvertedTime(false, time)!;
    }

    if (date.split("-").length == 3 && time.split(":").length == 3) {
      DateTime dateTime = DateTime.parse("$date $time");
      return dateTime;
    } else if (date.split("-").length == 3 && time.split(":").length == 2) {
      DateTime dateTime = DateTime.parse("$date ${time.split("-")[0]}:${time.split("-")[1]}:00");
      return dateTime;
    } else {
      return DateTime.now();
    }
  }
}
