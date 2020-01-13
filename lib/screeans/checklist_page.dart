import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckListPage extends StatefulWidget {
  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  List<bool> listChecked = [false, false];
  List<String> todoList = ['flutter study', "we'll do"];
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
        appBar: AppBar(title: Text("We'll do")),
        body: AnimatedList(
          initialItemCount: (todoList.isEmpty) ? 0 : todoList.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return (makeCheckbox(
              todoList[index],
              index,
            ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => questionAddSchedule(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  makeCheckbox(String todo, int index) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: listChecked[index],
      title: Text(todo,
          style: (listChecked[index])
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : null),
      onChanged: (_) {
        setState(() {
          listChecked[index] = !listChecked[index];
        });
      },
    );
  }

  questionAddSchedule(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) => AlertDialog(
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                todoList.add(_todoName.text);
                                listChecked.add(false);
                                _todoName.clear();
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ]));
  }
}
