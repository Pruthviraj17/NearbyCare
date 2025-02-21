import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.blue)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Color.fromARGB(40, 0, 0, 0),
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: const Color.fromARGB(255, 255, 255, 255),
    primary: Colors.white,
    // secondary: Colors.white,
    // tertiary: const Color(0xff1E232C),
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    headerBackgroundColor: Colors.blue[200],
    dayOverlayColor: const WidgetStatePropertyAll(Colors.black),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  ),
);
