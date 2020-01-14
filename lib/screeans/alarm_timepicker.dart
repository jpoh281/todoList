import 'package:flutter/material.dart';
import 'package:todolist_jpoh/model/alarm.dart';
import 'package:todolist_jpoh/widget/circleday.dart';

class AlarmTimePickerPage extends StatefulWidget {
  final Alarm alarm;

  const AlarmTimePickerPage({this.alarm});
  @override
  _AlarmTimePickerPageState createState() => _AlarmTimePickerPageState();
}

class _AlarmTimePickerPageState extends State<AlarmTimePickerPage> {
  TextEditingController alarmTitleController = TextEditingController();
  ValueChanged<TimeOfDay> selectTime;
  String _title;
  TimeOfDay _time;
  bool _repetition;
  List<bool> _repetitionDay = [false, false, true, false, true, false, false];
  @override
  void initState() {
    alarmTitleController = new TextEditingController(
        text: widget.alarm != null ? widget.alarm.title : null);
    _time = TimeOfDay.now();
    _repetition = false;
    super.initState();
  }

  @override
  void dispose() {
    alarmTitleController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarm == null ? "New Alarm" : "Edit Alarm"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: alarmTitleController,
                autofocus: false,
                onEditingComplete: null,
                decoration: InputDecoration(labelText: '알람 설명'),
              ),
            ),
            CheckboxListTile(
              title: Text('반복'),
              value: (widget.alarm == null)
                  ? _repetition
                  : widget.alarm.repetition,
              onChanged: (value) {
                setState(() {
                  if (widget.alarm == null)
                    _repetition = !_repetition;
                  else
                    widget.alarm.repetition = !widget.alarm.repetition;
                });
              },
            ),
            Visibility(
              visible: (widget.alarm == null)
                  ? _repetition
                  : widget.alarm.repetition,
              child: buildCircleDay(context),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                buildRaisedButton(context, '저장'),
                Spacer(),
                buildRaisedButton(context, '취소'),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildCircleDay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[0] = !_repetitionDay[0];
              });
            },
            child: circleDay("월", context, _repetitionDay[0])),
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[1] = !_repetitionDay[1];
              });
            },
            child: circleDay("화", context, _repetitionDay[1])),
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[2] = !_repetitionDay[2];
              });
            },
            child: circleDay("수", context, _repetitionDay[2])),
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[3] = !_repetitionDay[3];
              });
            },
            child: circleDay("목", context, _repetitionDay[3])),
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[4] = !_repetitionDay[4];
              });
            },
            child: circleDay("금", context, _repetitionDay[4])),
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[5] = !_repetitionDay[5];
              });
            },
            child: circleDay("토", context, _repetitionDay[5])),
        GestureDetector(
            onTap: () {
              setState(() {
                _repetitionDay[6] = !_repetitionDay[6];
              });
            },
            child: circleDay("일", context, _repetitionDay[6])),
      ],
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

  RaisedButton buildRaisedButton(BuildContext context, String title) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),
      ),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      onPressed: () {
        if (title == '저장')
          submit();
        else
          cancel();
      },
    );
  }

  void submit() {
    Navigator.of(context).pop((){
      widget.alarm.title = alarmTitleController.text;
      widget.alarm.time = _time;
      if(  widget.alarm.repetition != null){
        widget.alarm.repetition = widget.alarm.repetition;
      } else{
        widget.alarm.repetition = _repetition;
      }
      if(widget.alarm.repetition){
        widget.alarm.repetitionDay = _repetitionDay;
      }
      widget.alarm.onWork = true;
      return widget.alarm;
    });
  }

  void cancel() {
    Navigator.of(context).pop();
  }
}
