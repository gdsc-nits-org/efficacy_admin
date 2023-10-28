import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final void Function() onPressed;
  const UploadButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double buttonWidth = width * 0.4;
    double buttonFontSize = 20;
    return SizedBox(
      width: buttonWidth,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.file_upload_outlined,
              size: 30,
            ),
            Text(
              'Upload',
              style: TextStyle(fontSize: buttonFontSize),
            )
          ],
        ),
      ),
    );
  }
}
