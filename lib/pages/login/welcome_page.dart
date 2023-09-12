import 'package:efficacy_admin/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  //route
  static const String routeName = "/WelcomePage";

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.25;
    double gap1 = height * 0.05;
    double gap2 = height * 0.02;
    double gap3 = height * 0.1;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //circle avatar which will show the user's profile pic
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
              radius: avatarRadius,
              child: const SizedBox(),
            ),

            SizedBox(
              height: gap1,
            ),

            //welcome message
            const Text(
              "Hey! Welcome",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),

            SizedBox(
              height: gap2,
            ),

            //text
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suscipit sed augue quam amet, sed gravida.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.black.withOpacity(0.65)),
              ),
            ),

            SizedBox(
              height: gap3,
            ),

            //sign in with google button
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                child: Image.asset(
                    "assets/images/btn_google_signin_light_normal_web@2x 1.png"))
          ],
        ),
      ),
    );
  }
}
