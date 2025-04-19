import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String text;
  VoidCallback onPressed;

  MyButton({super.key , required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color.fromARGB(255, 225, 196, 196),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          ),
        ),
    );
  }
}