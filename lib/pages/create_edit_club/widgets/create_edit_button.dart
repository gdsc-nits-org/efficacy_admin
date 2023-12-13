import 'package:flutter/material.dart';

class CreateEditButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  const CreateEditButton({super.key, required this.onPressed,required this.label});

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
          label,
          style: TextStyle(fontSize: buttonFontSize),
        ),
      ),
    );
  }
}
