import 'package:flutter/material.dart';

SnackBar _errorSnackBar(String message, BuildContext context) {
  return SnackBar(
    content: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(message),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
  );
}

void showErrorSnackBar(BuildContext context, String message) {
  // To remove the current error snackbar when another error is encountered
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(_errorSnackBar(message, context));
  });
}
