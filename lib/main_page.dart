import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("We'll do"),
        ),
        body: Column(
          children: <Widget>[
            CheckboxListTile(
              title: const Text('Flutter Study'),
              value: _isChecked,
              onChanged: (_) {
                setState(() {
                  _isChecked = !_isChecked;
                });
              },
              secondary: Icon(Icons.hourglass_empty),
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () => addSchedule(context)),
            ),
          ],
        ),
      ),
    );
  }
}

addSchedule(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
              title: Text('To do List'),
              content: Text('Do you want to add To do List?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                ),
                FlatButton(
                  child: Text('Yes'),
                ),
              ]));
}
