import 'package:flutter/material.dart';

Map<String, int> calculateTimeDifference(DateTime targetDateTime) {
  DateTime currentDateTime = DateTime.now();
  Duration difference = targetDateTime.difference(currentDateTime);

  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;

  return {
    'days': days,
    'hours': hours,
    'minutes': minutes,
  };
}
