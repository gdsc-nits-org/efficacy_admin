import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadEvent extends StatefulWidget {
  //route
  static const String routeName = '/UploadPage';

  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  File? _image;

  //function to get image from gallery
  Future _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen size
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //constants
    double buttonLeftPos = width * 0.32;
    double buttonTopPos = height * 0.15;
    double buttonHeight = height * 0.05;
    double buttonWidth = width * 0.35;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _image == null
                    ? Image.asset(
                        "assets/images/media.png",
                        width: width,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.file(
                        _image!,
                        width: width,
                        fit: BoxFit.fitWidth,
                      ),
                Positioned(
                    left: buttonLeftPos,
                    top: buttonTopPos,
                    child: SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: _getImage,
                          child: const Text("Change poster")),
                    ))
              ],
            ),
            Form(
                child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
            ))
          ],
        ),
      ),
    );
  }
}
