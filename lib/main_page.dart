import 'package:flutter/material.dart';
import 'package:todolist_jpoh/screeans/alarm_main.dart';
import 'package:todolist_jpoh/screeans/todo_main.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;
  static List<Widget> selectedPageList = <Widget>[
    ToDoMain(),
    AlarmMainPage(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          title: Text("We'll do", key: Key('main-app-title')),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedPageIndex,
          children: selectedPageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.edit), title: Text('To-do')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.alarm), title: Text('Alarm')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sentiment_satisfied), title: Text('Diary')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assessment), title: Text('Report')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('Setting'))
            ]),
      ),
    );
  }
}
