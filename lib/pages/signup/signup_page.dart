import 'dart:io';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';

import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/SignUpPage';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String selectedClub = 'GDSC';

  List<String> clubs = [
    'GDSC',
    'Eco Club',
    'Item 3',
    'Item 4',
  ];

  File? _image;

  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double formWidth = width * 0.8;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileImageViewer(
                  onImageChange: (String? imagePath) {
                    if (imagePath != null) _image = File(imagePath);
                  },
                ),

                //login form
                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: formWidth,
                    child: Column(
                      children: [
                        //email field
                        TextFormField(
                          controller: emailController,
                          validator: Validator.isEmailValid,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "efficacy789@gmail.com",
                          ),
                        ),

                        //name field
                        TextFormField(
                          controller: nameController,
                          validator: (value) =>
                              Validator.nullCheck(value, "Name"),
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
                        CustomDropDown(
                          items: clubs,
                          initialValue: selectedClub,
                          onItemChanged: (String? newSelectedClub) {
                            if (newSelectedClub != null) {
                              selectedClub = newSelectedClub;
                            }
                          },
                        ),

                        //sign up button
                        ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.validate();
                          },
                          child: const Text("Sign Up"),
                        ),

                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Club not in the list?",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(128, 128, 128, 1)),
                            ),
                            Text(
                              "Mail us at mail@gdsc",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(5, 53, 76, 1)),
                            )
                          ],
                        )
                      ].separate(gap),
                    ),
                  ),
                )
              ].separate(gap),
            ),
          ),
        ),
      ),
    );
  }
}
