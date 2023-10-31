import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  //route
  static const String routeName = "/LoginPage";
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  IconData passVisibility = Icons.visibility;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }

  void login() async {
    await UserController.login(email: "raj@gmail.com", password: "123456");
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.15;
    double fieldGap = height * 0.005;
    double gap = height * 0.05;
    double smallGap = height * 0.01;
    double messageFieldWidth = 0.85;
    double formWidth = width * 0.8;
    double fieldHeight = height * 0.09;

    return WillPopScope(
      onWillPop: () async {
        final quitCondition = await showExitWarning(context);
        return quitCondition ?? false;
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: avatarRadius,
                  child: Image.asset(Assets.efficacyAdminLogoImagePath),
                ),
                Text(
                  "Hey! Welcome",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                FractionallySizedBox(
                  widthFactor: messageFieldWidth,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suscipit sed augue quam amet, sed gravida.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Column(
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
                                validator: (value) =>
                                    Validator.nullCheck(value, "Password"),
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
                                      color:
                                          const Color.fromARGB(255, 67, 67, 67),
                                    )),
                                prefixIcon: Icons.lock,
                              ),
                              Gap(fieldGap),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UserController.login(
                                        email: _emailController.text.toString(),
                                        password:
                                            _passController.text.toString());
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
                        Navigator.pushNamed(
                            context, SignUpUserDetailsPage.routeName);
                      },
                      child: RichText(
                        text: const TextSpan(
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                      color: dark,
                                      decoration: TextDecoration.underline))
                            ],
                            style: TextStyle(color: shadow)),
                      ),
                    ),
                  ].separate(smallGap),
                ),
              ].separate(gap),
            ),
          ),
        ),
      ),
    );
  }
}
