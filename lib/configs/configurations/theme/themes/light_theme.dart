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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 4,
      backgroundColor: dark,
      foregroundColor: light,

    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: dark,
      foregroundColor: light,
    )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: light,
      shadowColor: shadow,
    )
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: light,
    iconTheme: IconThemeData(color: accent),
  ),
);
