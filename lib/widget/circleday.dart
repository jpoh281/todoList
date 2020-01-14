import 'package:flutter/material.dart';

Widget circleDay(String day, BuildContext context, bool checked) {
  return Container(
    width: MediaQuery.of(context).size.width / 9,
    height: MediaQuery.of(context).size.width / 9,
    decoration: BoxDecoration(
        color: (checked) ? Theme.of(context).accentColor : Colors.transparent,
        borderRadius: BorderRadius.circular(100)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          day,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
