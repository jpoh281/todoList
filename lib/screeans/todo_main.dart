import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_jpoh/model/todo.dart';
import 'package:todolist_jpoh/screeans/todo_create_update.dart';

class ToDoMain extends StatefulWidget {
  @override
  _ToDoMainState createState() => _ToDoMainState();
}

class _ToDoMainState extends State<ToDoMain> with TickerProviderStateMixin {
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
        onPressed: () => goToNewItemView(),
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
        itemBuilder: (BuildContext context, int index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: buildItem(items[index], index),
          );
        });
  }

  Widget buildItem(Todo item, int index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      onDismissed: (direction) => removeItemFromList(item, index),
      background: Container(
        color: Colors.grey,
      ),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  Widget buildListTile(item, index) {
    return ListTile(
      onTap: () => changeItemCompleteness(item),
      onLongPress: () => goToEditItemView(item),
      title: Text(
        item.title,
        key: Key('${item.hashCode}'),
        style: TextStyle(
          fontWeight: item.completed ? null : FontWeight.bold,
          color: item.completed ? Colors.black87 : Colors.orangeAccent,
          decoration: item.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Icon(
        item.completed ? Icons.check_box : Icons.check_box_outline_blank,
        key: Key('completed-icon-$index'),
      ),
    );
  }

  void changeItemCompleteness(Todo item) {
    setState(() {
      item.completed = !item.completed;
    });
  }

  void goToNewItemView() {
//    여기서 우리는 새로운 관점을 네비게이터 스택에 밀어넣고 있다.
//    MaterialPageRoute를 사용하면 왼쪽 상단 모서리에 있는 각 플랫폼에 대해
//    자동으로 백 버튼이 표시되는 Material 앱의 표준 동작을 얻을 수 있다.
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodoCreateNUpdate();
    })).then((title) {
      if (title != null) {
        addItem(Todo(title: title));
      }
    });
  }

  void addItem(Todo item) {
    items.insert(items.length, item);
    if (animatedListKey.currentState != null)
      animatedListKey.currentState.insertItem(0);
  }

  void goToEditItemView(Todo item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TodoCreateNUpdate(
        item: item,
      );
    })).then((title) {
      if (title != null) {
        editItem(item, title);
      }
    });
  }

  void editItem(Todo item, String title) {
    item.title = title;
  }

  void removeItemFromList(Todo item, int index) {
    animatedListKey.currentState.removeItem(index, (context, animation) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    });
    deleteItem(item);
  }

  void deleteItem(Todo item) {
    // 다트 오브젝트는 모두 고유한 해시코드로 인식되기때문에
    // 우리는 항목 검색이 필요하지않다.
    // 이것의 의미는 단지 제거 방식에 의해 필요하다?

    items.remove(item);
    if (items.isEmpty) {
      emptyListController.reset();
      setState(() {});
      emptyListController.forward();
    }
  }
}
