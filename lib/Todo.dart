
import 'dart:ffi';

class Todo {
  String title;
  String memo;
  String category;
  int color;
  bool done;
  int date;

  Todo(this.title, this.memo, this.category, this.color, this.done,
      this.date);
}