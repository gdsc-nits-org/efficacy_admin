import 'dart:io';

import 'package:efficacy_admin/config/config.dart';
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
    double buttonLeftPos = width * 0.325;
    double buttonTopPos = height * 0.15;
    double buttonHeight = height * 0.05;
    double buttonWidth = width * 0.35;
    double containerRadius = 30.0;
    double borderWidth = 2;
    double boxRadius = 5;
    double iconSize = 30;
    double padding = 16;
    double lineWidth = width * 0.4;
    double linePadding = width * 0.3;
    double gap = 40;
    double fontSize = 25;
    double buttonFontSize = 22;

    return Scaffold(
      floatingActionButton: Container(
        width: buttonWidth,
        child: FloatingActionButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
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
      ),
      body: SafeArea(
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(containerRadius),
                        topRight: Radius.circular(containerRadius))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //line
                    Padding(
                      padding: EdgeInsets.only(top: gap, left: linePadding),
                      child: Container(
                        color: Colors.grey,
                        height: borderWidth,
                        width: lineWidth,
                      ),
                    ),
                    //title
                    Padding(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: borderWidth),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(boxRadius))),
                            hintText: 'Event Title',
                            icon: Icon(
                              Icons.title,
                              size: iconSize,
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    //short description
                    Padding(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: borderWidth),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(boxRadius))),
                            hintText: 'Short Description',
                            icon: Icon(
                              Icons.format_align_right_rounded,
                              size: iconSize,
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    //long description
                    Padding(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      child: TextFormField(
                        maxLines: 8,
                        maxLength: 500,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: borderWidth),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(boxRadius))),
                            hintText: 'Long Description',
                            icon: Icon(
                              Icons.format_align_right_rounded,
                              size: iconSize,
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    //start date and time
                    Padding(
                      padding: EdgeInsets.only(left: padding),
                      child: Text(
                        "Start Date & Time",
                        style: TextStyle(
                            color: Color.fromRGBO(5, 53, 76, 1),
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //end date and time
                    Padding(
                      padding: EdgeInsets.only(left: padding),
                      child: Text(
                        "End Date & Time",
                        style: TextStyle(
                            color: Color.fromRGBO(5, 53, 76, 1),
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //google form
                    Padding(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: borderWidth),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(boxRadius))),
                            hintText: 'Google Form URL',
                            icon: Icon(
                              Icons.link_outlined,
                              size: iconSize,
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    //FB form URL
                    Padding(
                      padding: EdgeInsets.only(left: padding, right: padding),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey, width: borderWidth),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(boxRadius))),
                            hintText: 'Facebook Form URL',
                            icon: Icon(
                              Icons.link_outlined,
                              size: iconSize,
                              color: Colors.black54,
                            )),
                      ),
                    ),
                    //Add Contacts
                    Padding(
                      padding: EdgeInsets.only(left: padding),
                      child: Text(
                        "Add Contacts",
                        style: TextStyle(
                            color: Color.fromRGBO(5, 53, 76, 1),
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ].separate(padding),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
