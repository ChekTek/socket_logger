import 'package:flutter/material.dart';

abstract class Themes {
  static final _primaryDarkColor = Color.fromARGB(255, 86, 168, 148);

  static final DarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _primaryDarkColor,
    toggleableActiveColor: _primaryDarkColor,
    secondaryHeaderColor: _primaryDarkColor,
    shadowColor: Colors.black26,
    errorColor: Color.fromARGB(255, 172, 71, 71),
  );
}
