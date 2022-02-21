import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        primaryColor: Color(0xFF304D63),
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.black,
        errorColor: Color(0xffBD1E1E),
        indicatorColor: Color(0xFF121F3E),
        fontFamily: 'Cairo',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      );
}
