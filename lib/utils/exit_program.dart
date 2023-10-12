import 'package:flutter/material.dart';

Future<bool?> showExitWarning(BuildContext context) async {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you want to exit the app?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("No")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Yes"))
              ],
              alignment: Alignment.center,
              actionsAlignment: MainAxisAlignment.spaceEvenly,

            ));
  }
  return null;
}
