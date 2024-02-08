import 'package:flutter/material.dart';
import '../utils/palette.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Comfortaa',
  colorScheme: const ColorScheme.light(
    primary: dark,
    secondary: accent,
  ),
  scaffoldBackgroundColor: light,
  useMaterial3: true,
  iconTheme: const IconThemeData(color: accent),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: dark,
    foregroundColor: light,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      minimumSize: const Size(264, 58),
      backgroundColor: dark,
      foregroundColor: light,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      backgroundColor: dark,
      foregroundColor: light,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: dark,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      backgroundColor: light,
      foregroundColor: shadow,
      shadowColor: shadow,
      minimumSize: const Size(230, 55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: const BorderSide(width: 0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: light,
    iconTheme: IconThemeData(color: accent),
  ),
);
