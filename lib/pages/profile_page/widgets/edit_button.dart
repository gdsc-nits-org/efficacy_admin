import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final void Function() onPressed;
  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double buttonWidth = width * 0.3;
    double buttonHeight = height * 0.06;
    double fontSize = 18;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.edit,
                size: fontSize,
              ),
              Text(
                "Edit",
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          )),
    );
  }
}
