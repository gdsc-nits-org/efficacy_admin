import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/login/widgets/google_sign_in_button.dart';

// import 'package:efficacy_admin/pages/sign_up/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  //route
  static const String routeName = "/LoginPage";

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.25;
    double gap = height * 0.05;
    double messageFieldWidth = 0.85;

    return Scaffold(
      body: SizedBox(
        width: width,
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
            const GoogleSignInButton()
          ].separate(gap),
        ),
      ),
    );
  }
}
