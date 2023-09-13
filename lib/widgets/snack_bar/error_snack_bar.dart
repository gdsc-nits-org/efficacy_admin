import 'package:flutter/material.dart';

SnackBar _errorSnackBar(String message) {
  /// TODO: Update the design
  return SnackBar(
    content: Text(message),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  // To remove the current error snackbar when another error is encountered
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar(message));
}
