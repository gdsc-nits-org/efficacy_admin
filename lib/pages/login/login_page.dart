import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginpage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File? _image;
  ImagePicker picker = ImagePicker();

  _imgFromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  String dropdownvalue = 'GDSC';

  // List of items in our dropdown menu
  var items = [
    'GDSC',
    'Eco Club',
    'Item 3',
    'Item 4',
  ];

  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.2;
    double gap1 = height * 0.01;
    double gap2 = height * 0.02;
    double formWidth = width * 0.8;
    double gap3 = height * 0.04;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _showPicker(context),
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                radius: avatarRadius,
                child: _image != null
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(avatarRadius),
                        clipBehavior: Clip.hardEdge,
                    child: Image.file(_image!,fit: BoxFit.fitHeight,
                    height: 180,))
                    : const SizedBox(),
              ),
            ),
            SizedBox(
              height: gap2,
            ),

            //login form
            Form(
                child: SizedBox(
              width: formWidth,
              child: Column(
                children: [
                  //email field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "efficacy789@gmail.com",
                    ),
                  ),

                  SizedBox(
                    height: gap2,
                  ),

                  //name field
                  TextFormField(
                    decoration: const InputDecoration(hintText: "John Doe"),
                  ),

                  SizedBox(
                    height: gap2,
                  ),

                  //intl number field
                  const IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "9077900",
                      hintStyle: TextStyle(color: Color.fromRGBO(5, 53, 75, 1)),
                    ),
                    initialCountryCode: 'IN',
                  ),

                  SizedBox(
                    height: gap2,
                  ),

                  //club menu field
                  DropdownButton(
                    isExpanded: true,
                    dropdownColor: const Color.fromRGBO(237, 249, 255, 1),
                    style: const TextStyle(color: Color.fromRGBO(5, 53, 75, 1)),
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),

                  SizedBox(
                    height: gap3,
                  ),

                  //sign up button
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Sign Up")),
                  SizedBox(
                    height: gap1,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Club not in the list?",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(128, 128, 128, 1)),
                      ),
                      Text(
                        "mail us at mail@gdsc",
                        style: TextStyle(
                            fontSize: 12, color: Color.fromRGBO(5, 53, 76, 1)),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
