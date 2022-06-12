import 'package:flutter/material.dart';
import 'package:todo_app/TodoCardWidget.dart';
import 'package:todo_app/DateParseHepler.dart';
import 'package:todo_app/write/TodoWritePage.dart';

import 'Todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Todo App Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [
    Todo("Dummy", "DummyMemo", "DummyCategory", Colors.red.value, false,
        2022612),
    Todo("Dummy2", "DummyMemo", "DummyCategory", Colors.blue.value, true,
        2022612),
    Todo("Dummy3", "DummyMemo", "DummyCategory", Colors.green.value, false,
        2022612),
    Todo("Dummy4", "DummyMemo", "DummyCategory", Colors.amber.value, true,
        2022612)
  ];
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: getPage(),
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      child: AppBar(),
      preferredSize: Size.fromHeight(0), // 화면 최상단부터 시작되는것 방지, appBar size: 0
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // TodoList 작성 화면 모달 띄우기
        Todo _todo = await Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => TodoWritePage(
                todo: Todo("", "", "", 0, false,
                    DateParseHelper.getFormatTime(DateTime.now())))));
        setState(() {
          todos.add(_todo);
        });
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined), label: "Today"),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined), label: "기록"),
        BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined), label: "더보기"),
      ],
      currentIndex: currentTabIndex,
      onTap: (idx) {
        setState(() {
          currentTabIndex = idx;
        });
      },
    );
  }

  Widget getPage(){
    if(currentTabIndex == 0) {
      return getMain();
    } else if (currentTabIndex == 1) {
      return getHistory();
    } else {
      return getMore();
    }
  }

  Widget getMain(){
    List<Todo> doneItems = [];
    List<Todo> toDoItems = [];
    for (var item in todos) {
      if (item.done) {
        doneItems.add(item);
      } else {
        toDoItems.add(item);
      }
    }
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        if (idx == 0) {
          return Container(
            child: Text(
              "오늘 해야 할일",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.center,
          );
        } else if (idx == 1) {
          return Container(
              child: Column(
                  children: List<Widget>.generate(toDoItems.length, (index) {
                    Todo todo = toDoItems[index];
                    if (todo.done) return Container();
                    return InkWell(
                        onTap: () {
                          if (!todo.done) {
                            setState(() {
                              todo.done = true;
                            });
                          }
                        },
                        onLongPress: () async {
                          Todo _todo = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => TodoWritePage(todo: todo)));
                          setState(() {
                            todo = _todo;
                          });
                        },
                        child: TodoCardWidget(todo: todo));
                  })));
        } else if (idx == 2) {
          return Container(
            child: Text(
              "오늘 완료 한일",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.center,
          );
        } else {
          return Container(
              child: Column(
                  children: List<Widget>.generate(doneItems.length, (index) {
                    Todo todo = doneItems[index];
                    if (!todo.done) return Container();
                    return InkWell(
                        onTap: () {
                          if (todo.done) {
                            setState(() {
                              todo.done = false;
                            });
                          }
                        },
                        onLongPress: () async {
                          Todo _todo = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => TodoWritePage(todo: todo)));
                          setState(() {
                            todo = _todo;
                          });
                        },
                        child: TodoCardWidget(todo: todo));
                  })));
        }
      },
      itemCount: 4,
    );
  }

  Widget getHistory(){
    return Container(
      alignment: Alignment.center,
        child: Text("기록 페이지 만드는중", style: TextStyle(fontSize: 30),)
    );
  }

  Widget getMore(){
    return Container(
        alignment: Alignment.center,
        child: Text("더보기 페이지 만드는중", style: TextStyle(fontSize: 30),)
    );
  }
}
