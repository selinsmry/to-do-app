import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{

  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('mybox');

  // run this method if this is the first time ever openning this app.
  void createInitialData(){
    toDoList = [
      ["Learn Flutter", false],
      ["Use To Do app", false],
    ];
  }

  //load the data from the database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateData(){
    _myBox.put("TODOLIST", toDoList);
  }

}