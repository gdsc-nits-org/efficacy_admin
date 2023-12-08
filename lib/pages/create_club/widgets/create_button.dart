import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final void Function() onPressed;
  const CreateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double buttonWidth = width * 0.4;
    double buttonFontSize = 20;
    return SizedBox(
      width: buttonWidth,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Text(
          'Create',
          style: TextStyle(fontSize: buttonFontSize),
        ),
      ),
    );
  }
}
