import 'package:flutter/material.dart';
import 'package:todolist_jpoh/screeans/todo_main.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;
  static List<Widget> selectedPageList = <Widget>[
    ToDoMain(),
    Container(),
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
                  icon: Icon(Icons.search), title: Text('Search')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group), title: Text('Group')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), title: Text('Talk')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('Setting'))
            ]),
      ),
    );
  }
}
