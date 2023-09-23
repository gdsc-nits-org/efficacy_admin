import 'dart:io';

import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/widgets/drop_down_menu/drop_down_menu.dart';
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
  //form key
  final _formKey = GlobalKey<FormState>();

  //image variables
  File? _image;
  ImagePicker picker = ImagePicker();

  //function to click photo from camera
  _imgFromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  //function to choose image from gallery
  _imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  //function to show image picker
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
                    onTap: () async {
                      await _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    await _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.2;
    double gap = height * 0.02;
    double formWidth = width * 0.8;
    double imageHeight = 180;

    //textcontrollers
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //profile picture image picker
            InkWell(
              onTap: () => _showPicker(context),
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                radius: avatarRadius,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(avatarRadius),
                        clipBehavior: Clip.hardEdge,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.fitHeight,
                          height: imageHeight,
                        ))
                    : const SizedBox(),
              ),
            ),

            //login form
            SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: SizedBox(
                    width: formWidth,
                    child: Column(
                      children: [
                        //email field
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (!value!.contains("@")) {
                              return "invalid email";
                            } else if (value.isEmpty) {
                              return "email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "efficacy789@gmail.com",
                          ),
                        ),

                        //name field
                        TextFormField(
                          controller: nameController,
                          validator: (value) =>
                              value!.isEmpty ? "name cannot be empty" : null,
                          decoration:
                              const InputDecoration(hintText: "John Doe"),
                        ),

                        //intl number field
                        const IntlPhoneField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "9077900",
                            hintStyle:
                                TextStyle(color: Color.fromRGBO(5, 53, 75, 1)),
                          ),
                          initialCountryCode: 'IN',
                        ),

                        //club menu field
                        const DropDownMenu(),

                        //sign up button
                        ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.validate();
                            },
                            child: const Text("Sign Up")),

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
                                  fontSize: 12,
                                  color: Color.fromRGBO(5, 53, 76, 1)),
                            )
                          ],
                        )
                      ].separate(gap),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
