import 'package:flutter/material.dart';
import 'package:todo_app/Todo.dart';

class TodoCardWidget extends StatelessWidget {
  final Todo todo;

  const TodoCardWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(todo.color), borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                todo.done ? "완료" : "미완료",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          Text(""),
          Text(
            todo.memo,
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }
}
