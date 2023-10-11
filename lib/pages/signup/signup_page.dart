import 'dart:io';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';

import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';

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
  TextEditingController scholarIDController = TextEditingController();
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
                          validator: Validator.isNameValid,
                          decoration:
                              const InputDecoration(hintText: "John Doe"),
                        ),

                        //scholar ID field
                        TextFormField(
                          controller: scholarIDController,
                          validator: Validator.isScholarIDValid,
                          decoration:
                              const InputDecoration(hintText: "2212072"),
                        ),

                        //intl number field
                        const CustomPhoneField(),

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

                        // Toggle button to login page
                        TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, LoginPage.routeName);
                          },
                          child: RichText(
                            text: const TextSpan(
                                text: "Already have an account? ",
                                children: [
                                  TextSpan(
                                      text: "Log In",
                                      style: TextStyle(
                                          color: dark,
                                          decoration: TextDecoration.underline))
                                ],
                                style: TextStyle(color: shadow)),
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Club not in the list?",
                              style: TextStyle(fontSize: 12, color: shadow),
                            ),
                            RichText(
                                text: const TextSpan(
                              text: "Mail us at ",
                              children: [
                                TextSpan(
                                    text: "mail@gdsc",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: dark))
                              ],
                              style: TextStyle(fontSize: 12, color: shadow),
                            )),
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
