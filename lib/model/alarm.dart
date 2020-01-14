import 'package:flutter/material.dart';

class Alarm {
  String title;
  TimeOfDay time;
  bool onWork;
  bool repetition;
  List<bool> repetitionDay = [false, false, false, false, false, false, false];

  Alarm({
    this.title,
    @required this.time,
    this.onWork = true,
    this.repetition = false,
    this.repetitionDay,
  });

  Alarm.fromMap(Map<String, dynamic> map)
      : title = map['Title'],
        onWork = map['OnWork'],
        time = map['Time'],
        repetition = map['Repetition'],
        repetitionDay = map['RepetitionDay'];

  updateTitle(title) {
    this.title = title;
  }

  Map toMap() {
    return {
      'title': title,
      'onWork': onWork,
      'Time': time,
      'Repetition': repetition,
      'RepetitionDay': repetitionDay
    };
  }
}
