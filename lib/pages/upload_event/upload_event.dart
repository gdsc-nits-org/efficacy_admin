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

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _image == null?
                Image.asset(
                  "assets/images/media.png",
                  width: width,
                  fit: BoxFit.fitWidth,
                ): Image.file(_image!),
                Positioned(
                    left: width * 0.32,
                    top: height * 0.15,
                    child: SizedBox(
                      height: height * 0.05,
                      width: width * 0.35,
                      child: ElevatedButton(
                          onPressed: _getImage,
                          child: const Text("Change poster")),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
