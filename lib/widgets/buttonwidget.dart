import 'package:flutter/material.dart';

class Buttonwidget extends StatelessWidget {
  const Buttonwidget(
      {required this.text, required this.color, required this.onpress});
  final String text;
  final Color color;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
