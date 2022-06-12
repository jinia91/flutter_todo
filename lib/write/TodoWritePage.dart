
import 'package:flutter/material.dart';
import 'package:todo_app/Todo.dart';

class TodoWritePage extends StatefulWidget {
  final Todo todo;

  TodoWritePage({Key? key, required this.todo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TodoWritePageState();
  }
}

class _TodoWritePageState extends State<TodoWritePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  int colorIdx = 0;
  int categoryIdx = 0;


  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
    memoController.text = widget.todo.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(
            onPressed: () {
              widget.todo.title = titleController.text;
              widget.todo.memo = memoController.text;

              Navigator.of(context).pop(widget.todo);
            },
            child: Text(
              "저장",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView.builder(
          itemBuilder: (ctx, idx) {
            if (idx == 0) {
              return Container(
                child: Text(
                  "제목",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              );
            } else if (idx == 1) {
              return Container(
                child: TextField(
                  controller: titleController,
                ),
                margin: EdgeInsets.symmetric(horizontal: 14),
              );
            } else if (idx == 2) {
              return InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "색상",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        color: Color(widget.todo.color),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  List<Color> colors = [
                    Colors.red,
                    Colors.blue,
                    Colors.green,
                    Colors.yellow,
                  ];
                  widget.todo.color = colors[colorIdx].value;
                  setState(() {
                    colorIdx = ++colorIdx % colors.length;
                  });
                },
              );
            } else if (idx == 3) {
              return InkWell(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "카테고리",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.todo.category, style: TextStyle(fontSize: 20,),),
                  ],
                ),
              ),
                onTap: (){
                  List<String> categories = ["공부", "운동", "게임"];
                  widget.todo.category = categories[categoryIdx];
                  setState(() {
                    categoryIdx = ++categoryIdx % categories.length;
                  });

                },
              );
            } else if (idx == 4) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Row(
                  children: [
                    Text(
                      "메모",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else if (idx == 5) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: memoController,
                  maxLines: 10,
                  minLines: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
              );
            }
            return Container();
          },
          itemCount: 6),
    );
  }
}
