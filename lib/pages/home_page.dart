import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/my_button.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {

  //reference hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  double _buttonScale = 1.0;
  
  @override
  void initState() {
    // if this is the first time ever opening the app, then create default data.
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  // save new tasks
  void saveNewTask() {
  if (_controller.text.isEmpty) {
    // If user tries to save an empty task
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(top: 50.0),
          backgroundColor: Color(0xFFE6CACA),
          title: Text(
            "Task can't be empty!",
            textAlign: TextAlign.center,
            style: TextStyle( fontWeight: FontWeight.bold ),
            ),
           
          content: Text(
          "Please enter a task before saving.",
          textAlign: TextAlign.center,),
          
          actions: <Widget>[
            MyButton(
              text: "OK",
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
              
            ),
          ],
        );
      },
    );
  } else {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }
}


  // Create new tasks button
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
      
    );
  }

  //Delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6CACA),
      appBar: AppBar(
        backgroundColor: Color(0xFFDBB5B5),
        title: Text(
          'TO DO',
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
          ),
        elevation: 2,
      ),

      // + BUTTON :Floating action button with scale effect
      floatingActionButton: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _buttonScale = 1.2; // Button grows when pressed
          });
        },
        onTapUp: (_) {
          setState(() {
            _buttonScale = 1.0; // Button returns to normal size after press
          });
        },
        onTapCancel: () {
          setState(() {
            _buttonScale = 1.0; // Button returns to normal size if press is cancelled
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150), // Animation duration
          width: 56.0 * _buttonScale, // Button width
          height: 56.0 * _buttonScale, // Button height
          child: FloatingActionButton(
            onPressed: createNewTask,
            child: Icon(Icons.add),
            backgroundColor: Color(0xFFDBB5B5),
            foregroundColor: Colors.black,
          ),
        ),
      ),

      body: db.toDoList.isEmpty
      ? Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 100),
          constraints: BoxConstraints(maxWidth: 400),
        child: Text(
          "Add new tasks using + button!",
          style: TextStyle(
            fontSize: 18,
            color: const Color.fromARGB(255, 117, 116, 116),

          )
          ),
        )
      )
      
      : ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.toDoList[index][0],
              taskDone: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }, 
      ),
    );
  }
}
