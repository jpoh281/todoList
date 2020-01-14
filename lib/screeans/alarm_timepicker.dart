import 'package:flutter/material.dart';
import 'package:todolist_jpoh/model/alarm.dart';

class AlarmTimePickerPage extends StatefulWidget {
  final Alarm alarm;

  const AlarmTimePickerPage({this.alarm});
  @override
  _AlarmTimePickerPageState createState() => _AlarmTimePickerPageState();
}

class _AlarmTimePickerPageState extends State<AlarmTimePickerPage> {
  ValueChanged<TimeOfDay> selectTime;
  TimeOfDay _time;
  @override
  void initState() {
    _time = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarm == null ? "New Alarm" : "Edit Alarm"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
          ),
          Center(
            child: GestureDetector(
              child: Text(
                _time.format(
                  context,
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => _selectTime(context),
            ),
          ),
          Row(),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (BuildContext context, Widget child) {
          return Theme(
            child: child,
            data: ThemeData(primarySwatch: Colors.orange),
          );
        });
    if (picked != null) {
      setState(() {
        _time = picked;
      });
    } else {
      setState(() {
        _time = TimeOfDay.now();
      });
    }
  }
}
