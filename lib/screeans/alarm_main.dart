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
        onPressed: () => goToNewItemView(),
        child: Icon(Icons.add_alarm),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.alarm), Text("규칙적인 생활을 위해 알람을 맞춰봐요")],
          )),
    );
  }

  Widget buildListView() {
    return AnimatedList(
        key: animatedListKey,
        initialItemCount: items.length,
        itemBuilder: (BuildContext context, int index, animation) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizeTransition(
              sizeFactor: animation,
              child: buildItem(items[index], index),
            ),
          );
        });
  }

  Widget buildItem(Alarm item, int index) {
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

  Widget buildListTile(Alarm item, index) {
    return ListTile(
      //  onTap: () => changeItemCompleteness(item),
      onLongPress: () => goToEditItemView(item, index),
      title: Text(
        item.time.format(context),
        key: Key('${item.hashCode}'),
        style: TextStyle(
          fontWeight: item.onWork ? FontWeight.bold : FontWeight.bold,
          color: item.onWork ? Colors.black87 : Colors.grey,
          fontSize: 45,
        ),
      ),
      subtitle: Text(
        repeatDay(item),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      isThreeLine: true,
      trailing: Switch.adaptive(
          value: item.onWork, onChanged: (_) => changeItemOnWork(item)),
    );
  }

  void changeItemOnWork(Alarm item) {
    setState(() {
      item.onWork = !item.onWork;
    });
  }

  void goToNewItemView() {
//    여기서 우리는 새로운 관점을 네비게이터 스택에 밀어넣고 있다.
//    MaterialPageRoute를 사용하면 왼쪽 상단 모서리에 있는 각 플랫폼에 대해
//    자동으로 백 버튼이 표시되는 Material 앱의 표준 동작을 얻을 수 있다.
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AlarmTimePickerPage();
    })).then((alarm) {
      if (alarm != null) {
        addItem(alarm);
      }
    });
  }

  void addItem(Alarm item) {
    items.insert(items.length, item);
    if (animatedListKey.currentState != null)
      animatedListKey.currentState.insertItem(0);
  }

  void goToEditItemView(Alarm item, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AlarmTimePickerPage(
        alarm: item,
      );
    })).then((alarm) {
      if (alarm != null) {
        editItem(alarm, index);
      }
    });
  }

  void editItem(Alarm item, int index) {
    items[index] = item;
  }

  void removeItemFromList(Alarm item, int index) {
    animatedListKey.currentState.removeItem(index, (context, animation) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    });
    deleteItem(item);
  }

  void deleteItem(Alarm item) {
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

  String repeatDay(Alarm item) {
    List<String> dayName = ["월", "화", "수", "목", "금", "토", "일"];
    String day = "";
    for (int i = 0; i < item.repetitionDay.length; i++) {
      if (item.repetitionDay[i]) day += dayName[i] + "   ";
    }
    return day;
  }
}
