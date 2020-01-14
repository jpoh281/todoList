import 'package:flutter/material.dart';
import 'package:todolist_jpoh/model/alarm.dart';
import 'package:todolist_jpoh/screeans/alarm_timepicker.dart';

class AlarmMainPage extends StatefulWidget {
  @override
  _AlarmMainPageState createState() => _AlarmMainPageState();
}

class _AlarmMainPageState extends State<AlarmMainPage>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  List<Alarm> items = new List<Alarm>();
  AnimationController emptyListController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emptyListController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    emptyListController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return AlarmTimePickerPage();
          }));
        },
        child: Icon(Icons.add_alarm),
      ),
    );
  }

  Widget renderBody() {
//    if (items.length > 0) {
//      return buildListView();
//    } else {
    return emptyList();
    // }
  }

  Widget emptyList() {
    return Center(
      child: FadeTransition(
          opacity: emptyListController,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.alarm), Text("규칙적인 생활을 위해 알람을 맞춰봐요")],
          )),
    );
  }

//  Widget buildListView() {
//    return AnimatedList(
//        key: animatedListKey,
//        initialItemCount: items.length,
//        itemBuilder: (BuildContext context, int index, animation) {
//          return SizeTransition(
//            sizeFactor: animation,
//            child: buildItem(items[index], index),
//          );
//        });
//  }
}
