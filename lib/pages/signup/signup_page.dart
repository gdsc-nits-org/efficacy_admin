import 'dart:io';
import 'dart:typed_data';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/controllers/services/instituion/institution_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/edit_form.dart';
import 'package:efficacy_admin/pages/signup/widgets/nav_buttons.dart';
import 'package:efficacy_admin/pages/signup/widgets/steps.dart';
import 'package:efficacy_admin/utils/exit_program.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/SignUpPage';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageUserDetailsState();
}

class _SignUpPageUserDetailsState extends State<SignUpPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController scholarIDController = TextEditingController();
  PhoneNumber? phoneNumber;
  String gdscEmail = "gdsc@example.com";
  String selectedDegree = Degree.BTech.name;
  String selectedBranch = Branch.CSE.name;
  String selectedInstitute = 'NIT Silchar';

  List<String> institutes = [];

  Uint8List? _image;

  Future<void> init() async {
    institutes = (await InstitutionController.getAllInstitutions())
        .map((model) => model.name)
        .toList();
    if (institutes.isNotEmpty) {
      setState(() {
        institutes;
      });
    }
  }

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

  bool backButtonDisableChecker() {
    return activeStep == 0;
  }

  @override
  void initState() {
    super.initState();
    init();
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
        // resizeToAvoidBottomInset: false,
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
                      Steps(
                        activeStep: activeStep,
                        takeStep: takeStep,
                        onPressedStep: (int step) {
                          if (_formKey.currentState!.validate() &&
                              (activeStep - step).abs() == 1) {
                            setState(() {
                              takeStep = true;
                              activeStep = step;
                            });
                          }
                        },
                        onStepReached: (int index) {
                          setState(() {
                            activeStep = index;
                          });
                        },
                      ),
                      SizedBox(
                        width: formWidth,
                        child: EditForm(
                          step: activeStep,
                          emailController: emailController,
                          passwordController: passwordController,
                          confirmPasswordController: confirmPasswordController,
                          nameController: nameController,
                          scholarIDController: scholarIDController,
                          onPhoneChanged: (PhoneNumber newPhoneNumber) {
                            phoneNumber = newPhoneNumber;
                          },
                          onImageChanged: (Uint8List? newImage) {
                            _image = newImage;
                          },
                          selectedDegree: selectedDegree,
                          onDegreeChanged: (String? newSelectedDegree) {
                            if (newSelectedDegree != null) {
                              selectedDegree = newSelectedDegree;
                            }
                          },
                          selectedBranch: selectedBranch,
                          onBranchChanged: (String? newSelectedBranch) {
                            if (newSelectedBranch != null) {
                              selectedBranch = newSelectedBranch;
                            }
                          },
                          institutes: institutes,
                          selectedInstitute: selectedInstitute,
                          onInstituteChanged: (String? newSelectedInstitute) {
                            if (newSelectedInstitute != null) {
                              selectedInstitute = newSelectedInstitute;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                        width: formWidth,
                        child: NavButtons(
                          activeStep: activeStep,
                          onPressedBack: (int index) {
                            if (!backButtonDisableChecker()) {
                              setState(() {
                                --activeStep;
                              });
                            }
                          },
                          onPressedNext: (int index) async {
                            if (_formKey.currentState!.validate()) {
                              if (index == 2) {
                                UserModel? user;
                                showLoadingOverlay(
                                    context: context,
                                    asyncTask: () async {
                                      UploadInformation? info;
                                      if (_image != null) {
                                        info =
                                            await ImageController.uploadImage(
                                          img: _image!,
                                          name: nameController.text,
                                          folder: ImageFolder.userImage,
                                        );
                                      }
                                      user = await UserController.create(
                                        UserModel(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          scholarID: scholarIDController.text,
                                          userPhoto: info?.url,
                                          userPhotoPublicID: info?.publicID,
                                          phoneNumber: phoneNumber,
                                          branch: Branch.values.firstWhere(
                                              (branch) =>
                                                  branch.name ==
                                                  selectedBranch),
                                          degree: Degree.values.firstWhere(
                                              (degree) =>
                                                  degree.name ==
                                                  selectedDegree),
                                        ),
                                      );
                                    },
                                    onCompleted: () {
                                      if (user != null && mounted) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          Homepage.routeName,
                                          (_) => false,
                                        );
                                      }
                                    });
                              } else {
                                setState(() {
                                  ++activeStep;
                                });
                              }
                            }
                          },
                        ),
                      ),
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
}
