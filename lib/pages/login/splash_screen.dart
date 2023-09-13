import 'dart:async';

import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/pages/login/welcome_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  //route
  static const String routeName = "/splashscreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double avatarRadius = width * 0.25;
    double gap = height * 0.02;

    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //circle avatar to show user profile pic
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
              radius: avatarRadius,
              child: const SizedBox(),
            ),

            //Efficacy text
            const Text(
              "Efficacy",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
            ),
          ].separate(gap),
        ),
      ),
    );
  }
}
