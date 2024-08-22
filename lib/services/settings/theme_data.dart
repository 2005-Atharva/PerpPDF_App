import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Color.fromARGB(255, 238, 238, 238),
    secondary: Color.fromARGB(255, 34, 34, 34),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    primary: Color.fromARGB(255, 34, 34, 34),
    secondary: Color.fromARGB(255, 238, 238, 238),
  ),
);
