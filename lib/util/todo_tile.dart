import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

final String taskName;
final bool taskDone;
Function(bool?)? onChanged;
Function(BuildContext)? deleteFunction;


  TodoTile({
    super.key, 
    this.onChanged, 
    required this.taskDone, 
    required this.taskName,
    required this.deleteFunction
    });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:25.0, left: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 201, 39, 27),
              borderRadius: BorderRadius.circular(20),
              )
          ]
          ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskDone, 
                onChanged: onChanged,
                activeColor: Color(0xFF8C5B5B),
                ),
        
              // task name
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskDone ? TextDecoration.lineThrough : TextDecoration.none,
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                  ),
                ),
                
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xFFDBB5B5),
            borderRadius: BorderRadius.circular(20),
            ),
        ),
      ),
    );
  }
}