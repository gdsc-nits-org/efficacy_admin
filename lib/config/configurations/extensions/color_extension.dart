import 'dart:ui';

extension ColorExtension on Color {
  String toHexCode() {
    return "#${value.toRadixString(16).substring(2)}";
  }
}
