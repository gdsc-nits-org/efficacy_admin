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
        heroTag: "Create",
        child: Text(
          "Create",
          style: TextStyle(fontSize: buttonFontSize),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final void Function() onPressed;

  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //size constants
    double fontSize = 30;
    double pad = 18.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pad),
      child: IconButton(
          tooltip: "Edit Profile",
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
          onPressed: onPressed,
          icon: Icon(
            Icons.edit,
            size: fontSize,
            color: Colors.black,
          )),
    );
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

class InviteButton extends StatelessWidget {
  final void Function() onPressed;

  const InviteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double buttonHeight = height * 0.06;
    double fontSize = 18;
    return SizedBox(
      width: buttonHeight,
      height: buttonHeight,
      child: IconButton(
        tooltip: "Invite",
        onPressed: onPressed,
        icon: Icon(
          // Icons.group_add
          Icons.person_add_alt_1,
          size: fontSize,
        ),
      ),
    );
  }
}

class EditPositionButton extends StatelessWidget {
  final void Function() onPressed;

  const EditPositionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double buttonHeight = height * 0.06;
    double fontSize = 18;
    return SizedBox(
      width: buttonHeight,
      height: buttonHeight,
      child: IconButton(
        tooltip: "Edit Club Positions",
        onPressed: onPressed,
        icon: Icon(
          Icons.edit_note_outlined,
          size: fontSize,
        ),
      ),
    );
  }
}
