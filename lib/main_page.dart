import 'package:flutter/material.dart';
import 'package:todolist_jpoh/screeans/checklist_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;
  static List<Widget> selectedPageList = <Widget>[
    CheckListPage(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            selectedItemColor: Colors.blue,
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
