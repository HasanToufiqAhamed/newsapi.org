import 'package:flutter/material.dart';

extension DateExtensionDatabase on DateTime {
  String get formattedDateName => getDateName(this);
}

String getDateName(DateTime date) {
  int dateDiff = DateTime.now()
      .difference(DateTime(date.year, date.month, date.day, date.hour))
      .inHours;

  if (dateDiff == 0) {
    return 'Now';
  }
  else if (dateDiff > 1) {
    return '$dateDiff hours ago';
  }
  return '$dateDiff hour ago';
}
