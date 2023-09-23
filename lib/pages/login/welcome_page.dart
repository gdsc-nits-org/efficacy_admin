import 'package:efficacy_admin/config/config.dart';

import 'package:efficacy_admin/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

            //welcome message
            const Text(
              "Hey! Welcome",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
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

            //sign in with google button
            OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, LoginPage.routeName),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset("assets/images/google_logo.svg",
                        height: 50),
                    const Text(
                      "Sign In with Google",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ))
          ].separate(gap1),
        ),
      ),
    );
  }
}
