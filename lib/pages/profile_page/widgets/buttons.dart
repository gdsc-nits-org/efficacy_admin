import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final void Function() onPressed;

  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //size constants
    double fontSize = 30;
    return IconButton(
      tooltip: "Edit Profile",
       style: const ButtonStyle(
         backgroundColor: MaterialStatePropertyAll(Colors.transparent)
       ),
        onPressed: onPressed,
        icon: Icon(
          Icons.edit,
          size: fontSize,
          color: Colors.black,
        ));
  }
}

class SaveButton extends StatelessWidget {
  final void Function() onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double buttonWidth = width * 0.28;
    double buttonHeight = height * 0.06;
    double fontSize = 18;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.save,
              size: fontSize,
            ),
            Text(
              "Save",
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
