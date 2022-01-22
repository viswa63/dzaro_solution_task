import 'package:flutter/material.dart';
import 'package:products/util/ui/atl_text.dart';

class CommonService {
  static bool isTextIsLink(String text) {
    if (text.startsWith("www") ||
        text.startsWith("http") ||
        text.startsWith("https:") ||
        text.startsWith("www") ||
        text.endsWith(".com") ||
        text.endsWith(".in") ||
        text.endsWith(".io") ||
        text.endsWith(".info") ||
        text.endsWith(".net") ||
        text.endsWith(".org") ||
        text.endsWith(".dev")) {
      return true;
    } else {
      return false;
    }
  }

  /// It Returns (2021-08-03 00:00:00.000) else null
  static Future<DateTime?> getDateFromDatePicker(BuildContext context, DateTime initialDate, DateTime firstDate, DateTime lastDate, String helperText) async {
    return await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate, helpText: helperText);
  }

  /// It Returns TimeOf(18:00) else null
  static Future<TimeOfDay?> getTimeFromDatePicker(BuildContext context, TimeOfDay initialTime, DateTime firstDate, DateTime lastDate, String helperText) async {
    return await showTimePicker(
        initialTime: initialTime,
        context: context,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? Container(),
          );
        });
  }

  /// It Returns 2020 else null
  static Future<int?> yearPicker(BuildContext context, DateTime selectedDate, DateTime firstDate, DateTime lastDate, String helperText,
      {DateTime? initialDate}) async {
    int? year;
    await (showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ATLText(txt: helperText),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: firstDate,
              lastDate: lastDate,
              initialDate: initialDate,
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                Navigator.pop(context);
                year = dateTime.year;
              },
            ),
          ),
        );
      },
    ));
    return year;
  }

  ///   This Methods Says input is Numeric or String
  static bool isNumeric(String string) {
    if (string.isEmpty) {
      return false;
    }
    final number = num.tryParse(string);
    if (number == null) {
      return false;
    }
    return true;
  }
}
