import 'package:flutter/material.dart';
import 'package:todolist_jpoh/model/todo.dart';

class TodoCreateNUpdate extends StatefulWidget {
  final Todo item;

  const TodoCreateNUpdate({this.item});

  @override
  _TodoCreateNUpdateState createState() => _TodoCreateNUpdateState();
}

class _TodoCreateNUpdateState extends State<TodoCreateNUpdate> {
  TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = new TextEditingController(
        text: widget.item != null ? widget.item.title : null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? 'Edit Todo' : 'New Todo',
          key: Key('new-item-title'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: titleController,
              autofocus: true,
              onEditingComplete: null,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildRaisedButton(context, 'Save'),
                buildRaisedButton(context, 'Cancel'),
              ],
            )
          ],
        ),
      ),
    );
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
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      )),
      onPressed: title == 'Save' ? () => submit() : () => cancel(),
    );
  }

  void submit() {
    Navigator.of(context).pop(titleController.text);
  }

  void cancel() {
    Navigator.of(context).pop();
  }
}
