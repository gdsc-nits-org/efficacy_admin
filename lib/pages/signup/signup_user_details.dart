import 'dart:io';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/exit_program.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpUserDetailsPage extends StatefulWidget {
  static const String routeName = '/SignUpUserDetailsPage';

  const SignUpUserDetailsPage({super.key});

  @override
  State<SignUpUserDetailsPage> createState() => _SignUpPageUserDetailsState();
}

class _SignUpPageUserDetailsState extends State<SignUpUserDetailsPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool hidePassword = true;
  bool hideConfPassword = true;
  IconData passVisibility = Icons.visibility;
  IconData confPassVisibility = Icons.visibility;
  TextEditingController nameController = TextEditingController();
  TextEditingController scholarIDController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  String selectedClub = 'GDSC';
  String gdscEmail = "gdsc@example.com";
  String selectedDegree = 'BTech';
  String selectedBranch = 'CSE';
  String selectedInstitute = 'NIT Silchar';

  List<String> institute = ['NIT Silchar', 'NIT Trichy', 'A', 'B'];

  File? _image;

  // Function to launch default email app
  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Uri.encodeComponent(gdscEmail),
      query: 'subject=Addition of new club',
    );
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email');
    }
  }

  int activeStep = 0;
  bool takeStep = false;

  bool backButtonDisableCheker() {
    if (activeStep == 0) {
      return true;
    }
    return false;
  }

  Widget getButton() {
    if (activeStep != 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    (backButtonDisableCheker())
                        ? null
                        : setState(() {
                            --activeStep;
                          });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back_sharp),
                      Gap(MediaQuery.of(context).size.width * 0.05),
                      const Text("Back"),
                    ],
                  ),
                )),
          ),
          Gap(MediaQuery.of(context).size.width * 0.1),
          Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        ++activeStep;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Next"),
                      Gap(MediaQuery.of(context).size.width * 0.05),
                      const Icon(Icons.arrow_forward_sharp)
                    ],
                  ),
                )),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      (backButtonDisableCheker())
                          ? null
                          : setState(() {
                              --activeStep;
                            });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.arrow_back_sharp),
                        Gap(MediaQuery.of(context).size.width * 0.05),
                        const Text("Back"),
                      ],
                    ),
                  ))),
          Gap(MediaQuery.of(context).size.width * 0.1),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      UserController.create;
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign Up"),
                      ],
                    ),
                  ))),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double formWidth = width * 0.8;
    double vMargin = width * 0.16;

    return WillPopScope(
      onWillPop: () async {
        final quitCondition = await showExitWarning(context);
        return quitCondition ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(top: vMargin),
          child: SizedBox(
              width: width,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Hey! Welcome to Efficacy",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: vMargin * 0.5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: EasyStepper(
                                stepRadius: 22,
                                activeStep: activeStep,
                                steps: [
                                  EasyStep(
                                    customStep: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.person)),
                                    customTitle: const Text(
                                      'Credetials',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  EasyStep(
                                    customStep: IconButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              activeStep < 1) {
                                            setState(() {
                                              takeStep = true;
                                              activeStep = 1;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.group)),
                                    customTitle: const Text(
                                      "Personal Info",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  EasyStep(
                                    customStep: IconButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              activeStep == 1) {
                                            setState(() {
                                              takeStep = true;
                                              activeStep = 2;
                                            });
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.miscellaneous_services)),
                                    customTitle: const Text(
                                      "Misc",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                                steppingEnabled: takeStep,
                                onStepReached: (index) =>
                                    setState(() => activeStep = index),
                              ),
                            ),
                            // Gap(gap),
                          ].separate(gap),
                        ),
                      ),
                      SizedBox(
                          width: formWidth,
                          // height: height * 0.45,
                          child: getWidget()[activeStep]),
                      SizedBox(
                          height: height * 0.1,
                          width: formWidth,
                          child: getButton()),
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
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    return <Widget>[
      Column(
          children: [
        Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Account Details :",
              style: TextStyle(fontSize: 20),
            )),
        CustomTextField(
          label: "Email",
          height: MediaQuery.of(context).size.height * 0.09,
          prefixIcon: Icons.email,
          controller: emailController,
          validator: Validator.isEmailValid,
        ),
        CustomTextField(
          hiddenText: hidePassword,
          height: MediaQuery.of(context).size.height * 0.09,
          label: "Create Password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
              onPressed: () {
                if (passVisibility == Icons.visibility) {
                  setState(() {
                    passVisibility = Icons.visibility_off;
                    hidePassword = false;
                  });
                } else {
                  setState(() {
                    passVisibility = Icons.visibility;
                    hidePassword = true;
                  });
                }
              },
              icon: Icon(
                passVisibility,
                color: const Color.fromARGB(255, 67, 67, 67),
              )),
          controller: passController,
          validator: (value) => Validator.nullCheck(value, "Password"),
        ),
        CustomTextField(
            hiddenText: hideConfPassword,
            height: MediaQuery.of(context).size.height * 0.09,
            label: "Confirm Password",
            prefixIcon: Icons.lock,
            suffixIcon: IconButton(
                onPressed: () {
                  if (confPassVisibility == Icons.visibility) {
                    setState(() {
                      confPassVisibility = Icons.visibility_off;
                      hideConfPassword = false;
                    });
                  } else {
                    setState(() {
                      confPassVisibility = Icons.visibility;
                      hideConfPassword = true;
                    });
                  }
                },
                icon: Icon(
                  confPassVisibility,
                  color: const Color.fromARGB(255, 67, 67, 67),
                )),
            validator: (value) => Validator.isConfirmPassword(
                passController.text.toString(), value.toString())),
      ].separate(MediaQuery.of(context).size.height * 0.02)),
      Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Personal Information :",
                style: TextStyle(fontSize: 20),
              )),
          CustomTextField(
            controller: nameController,
            prefixIcon: Icons.person,
            label: "Name",
            height: MediaQuery.of(context).size.height * 0.09,
            validator: Validator.isNameValid,
          ),
          CustomTextField(
            controller: scholarIDController,
            prefixIcon: Icons.numbers,
            label: "Scholar ID",
            height: MediaQuery.of(context).size.height * 0.09,
            validator: Validator.isScholarIDValid,
          ),
          CustomPhoneField(
            controller: phnoController,
            label: "Phone No.",
          ),
        ].separate(MediaQuery.of(context).size.height * 0.02),
      ),
      Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Additional Info. :",
                style: TextStyle(fontSize: 20),
              )),
          ProfileImageViewer(
            height: 100,
            onImageChange: (String? imagePath) {
              if (imagePath != null) _image = File(imagePath);
            },
          ),
          CustomDropDown(
            title: "Degree",
            items: Degree.values.map((degree) => degree.name).toList(),
            initialValue: selectedDegree,
            onItemChanged: (String? newSelectedDegree) {
              if (newSelectedDegree != null) {
                selectedDegree = newSelectedDegree;
              }
            },
          ),
          CustomDropDown(
            title: "Branch",
            items: Branch.values.map((branch) => branch.name).toList(),
            initialValue: selectedBranch,
            onItemChanged: (String? newSelectedBranch) {
              if (newSelectedBranch != null) {
                selectedBranch = newSelectedBranch;
              }
            },
          ),
          CustomDropDown(
            title: "Institute",
            items: institute,
            initialValue: selectedInstitute,
            onItemChanged: (String? newSelectedInstitute) {
              if (newSelectedInstitute != null) {
                selectedInstitute = newSelectedInstitute;
              }
            },
          ),
        ].separate(MediaQuery.of(context).size.height * 0.016),
      ),
    ];
  }
}
