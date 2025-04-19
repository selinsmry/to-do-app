import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFE6CACA),
      content: Container(
        height: 200,
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Text(
            "Add a new task!",
            textAlign: TextAlign.center,
            style: TextStyle( 
              fontWeight: FontWeight.bold,
              fontSize: 20 ),
            ),
          //get user input
          TextField(
            controller: controller,
            decoration: InputDecoration( 
              filled: true,
              fillColor: Color.fromARGB(255, 241, 216, 216),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25), 
              ),
              hintText: "Add a new task",
              ),
          ),

          //buttons -> save and cancel button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            // button 1 -> save button
            MyButton(
              text: "Save", 
              onPressed: onSave,
            ),

            const SizedBox(width: 10),

            //button2 -> cancel button
            MyButton(
              text: "Cancel", 
              onPressed: onCancel,
            ),
            ],
          )
          ]
        )
      ),
      
    );
  }
}