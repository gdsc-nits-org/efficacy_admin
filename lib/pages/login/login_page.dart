import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/login/widgets/login_form.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  //route
  static const String routeName = "/LoginPage";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  IconData passVisibility = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.15;
    double gap = height * 0.05;
    double messageFieldWidth = 0.85;

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
                  const LoginForm(),
                ].separate(gap),
              ),
            ])))));
  }
}
