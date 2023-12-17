import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/pages/homepage/homepage.dart';
import 'package:efficacy_admin/pages/signup/signup_page.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool hidePassword = true;
  IconData passVisibility = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double fieldGap = height * 0.005;
    double smallGap = height * 0.01;
    double formWidth = width * 0.8;
    double fieldHeight = height * 0.09;

    return Column(
      children: [
        Form(
            key: _formKey,
            child: SizedBox(
              width: formWidth,
              child: Column(
                children: [
                  CustomTextField(
                    label: "Email",
                    height: fieldHeight,
                    controller: _emailController,
                    validator: Validator.isEmailValid,
                    prefixIcon: Icons.email,
                  ),
                  CustomTextField(
                    label: "Password",
                    height: fieldHeight,
                    controller: _passController,
                    hiddenText: hidePassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validator.isPasswordValid(value),
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
                    prefixIcon: Icons.lock,
                  ),
                  Gap(fieldGap),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        UserModel? user;
                        showLoadingOverlay(
                          context: context,
                          asyncTask: () async {
                            user = await UserController.login(
                              email: _emailController.text.toString(),
                              password: _passController.text.toString(),
                            );
                          },
                          onCompleted: () {
                            if (user != null && mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Homepage.routeName,
                                (route) => false,
                              );
                            }
                          },
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ].separate(fieldGap * 0.5),
              ),
            )),
        // Toggle button to signup page
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SignUpPage.routeName,
              (Route<dynamic> route) => false,
            );
          },
          child: RichText(
            text: const TextSpan(
                text: "Don't have an account? ",
                children: [
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                          color: dark, decoration: TextDecoration.underline))
                ],
                style: TextStyle(color: shadow)),
          ),
        ),
      ].separate(smallGap),
    );
  }
}
