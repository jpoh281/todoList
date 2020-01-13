import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_jpoh/model/todo.dart';

class CheckListPage extends StatefulWidget {
  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage>
    with TickerProviderStateMixin {
  List<Todo> items = new List<Todo>();
  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();
  AnimationController emptyListController;

  @override
  void initState() {
    emptyListController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    emptyListController.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget renderBody() {
    if (items.length > 0) {
      return buildListView();
    } else {
      return emptyList();
    }
  }

  Widget emptyList() {
    return Center(
      child: FadeTransition(
        opacity: emptyListController,
        child: Text('오늘은 어떤 계획이 있으신가요?'),
      ),
    );
  }

  Widget buildListView() {
    return AnimatedList(
        key: animatedListKey,
        initialItemCount: items.length,
        itemBuilder: null);
  }

  Widget buildItem(Todo item, int index){
    return Dismissible(
      key: Key('${item.hashCode}'),
      onDismissed: null,
      background: Container( color: Colors.grey,),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  Widget buildListTile(item, index){
    return ListTile(
      onTap: () => changeItemCompleteness(item),
      onLongPress: null,
      title: Text(
          item.title,
          key: Key('${item.hashCode}'),
          style: TextStyle(
          color: item.completed ? Colors.black87 : Colors.orangeAccent,
          decoration: item.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Icon(item.completed
          ?Icons.check_box
          :Icons.check_box_outline_blank,
          key: Key('completed-icon-$index'),),
    );
  }

  void changeItemCompleteness(Todo item){
    setState(() {
      item.completed = ! item.completed;
    });
  }

  void addItem(Todo item){
    items.insert(items.length, item);
    if(animatedListKey.currentState != null)
      animatedListKey.currentState.insertItem(0);
  }

  void editItem(Todo item, String title){
    item.title = title;
  }

  void deleteItem(Todo item){
    // 다트 오브젝트는 모두 고유한 해시코드로 인식되기때문에
    // 우리는 항목 검색이 필요하지않다.
    // 이것의 의미는 단지 제거 방식에 의해 필요하다?

    items.remove(item);
    if(items.isEmpty){
      emptyListController.reset();
      setState(() {});
      emptyListController.forward();
    }
  }
}
