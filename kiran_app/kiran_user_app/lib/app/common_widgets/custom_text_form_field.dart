import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';

Widget CustomTextField({
  required String labelText,
  required String hintText,
  Function(String?)? onSaved,
  Function(String?)? onChanged,
}) =>
    TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white54),
        labelText: labelText,
        hintText: hintText,
      ),
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        }
        return null;
      },
      onSaved: onSaved,
      onChanged: onChanged,
    );
