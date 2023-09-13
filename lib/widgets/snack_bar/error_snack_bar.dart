import 'package:flutter/material.dart';

SnackBar _errorSnackBar(String message, context) {
  /// TODO: Update the design
  return SnackBar(
    content: Text(message),
    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(_errorSnackBar(message, context));
}
