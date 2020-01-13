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

  TextEditingController _todoName = TextEditingController();

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
    // 낭비 방지를 위해 꺼줌. 컨트롤러를 꺼주자
    _todoName.dispose();
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
}
