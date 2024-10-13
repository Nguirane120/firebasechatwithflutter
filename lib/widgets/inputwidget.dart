import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  InputWidget(
      {required this.placeHolder,
      required this.onChange,
      this.keyBoard,
      this.obscurPassword});
  final String placeHolder;
  final Function(String) onChange;
  final TextInputType? keyBoard;

  final bool? obscurPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyBoard,
      obscureText: obscurPassword ?? false,
      style: TextStyle(color: Colors.black),
      onChanged: (value) {
        //Do something with the user input.
        onChange(value);
      },
      decoration: InputDecoration(
        // hintStyle: TextStyle(color: Colors.black),
        hintText: placeHolder,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
