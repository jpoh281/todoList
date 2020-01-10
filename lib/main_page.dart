import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isChecked = false;
  TextEditingController _todoName = TextEditingController();
  @override
  void dispose() {
    // 낭비 방지를 위해 꺼줌. 컨트롤러를 꺼주자
    _todoName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("We'll do"),
        ),
        body: ListView(
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

  addSchedule(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: Text('To do List'),
                content: Text('Do you want to add To do List?'),
                actions: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "What will you do today?"),
                          controller: _todoName,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          FlatButton(
                            child: Text('Yes'),
                          ),
                        ],
                      )
                    ],
                  ),
                ]));
  }
}
