import 'package:flutter/material.dart';

class MyTextFromField extends StatelessWidget {
  final TextEditingController myController;

  final String hintText;
  final TextInputType keybord;
  final bool myObscureText;
  MyTextFromField({this.hintText, this.keybord,this.myObscureText,this.myController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      obscureText:myObscureText,
      keyboardType: keybord,
      decoration: InputDecoration(
        fillColor: Color(0xfffef6fa),
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
