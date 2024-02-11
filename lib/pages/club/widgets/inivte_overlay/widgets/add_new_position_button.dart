import 'package:flutter/material.dart';

class AddNewPositionButton extends StatefulWidget {
  final TextEditingController newClubPositionController;
  final Future<void> Function() onTap;
  const AddNewPositionButton({super.key, required this.newClubPositionController, required this.onTap});

  @override
  State<AddNewPositionButton> createState() => _AddNewPositionButtonState();
}

class _AddNewPositionButtonState extends State<AddNewPositionButton> {
  String newClubPositionName = "";

  @override
  void initState() {
    super.initState();
    widget.newClubPositionController.addListener(() {
      setState(() {
        newClubPositionName = widget.newClubPositionController.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: newClubPositionName.isEmpty
          ? null
          : widget.onTap,
      child: const Text("Add"),
    );
  }
}
