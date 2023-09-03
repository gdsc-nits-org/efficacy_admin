import 'package:flutter/material.dart';
import '../utils/palette.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  /// Add a Font
  fontFamily: 'Comfortaa',
  colorScheme: const ColorScheme.light(
    primary: dark,
    secondary: accent,
  ),
  scaffoldBackgroundColor: light,
  useMaterial3: true,
  iconTheme: const IconThemeData(color: accent),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 2,
      backgroundColor: dark,
      foregroundColor: light,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      backgroundColor: dark,
      foregroundColor: light,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: light,
    iconTheme: IconThemeData(color: accent),
  ),
);
