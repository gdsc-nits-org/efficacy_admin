import 'dart:async';

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
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //circle avatar to show user profile pic
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
              radius: myWidth * 0.25,
              child: const SizedBox(),
            ),
            SizedBox(
              height: myHeight * 0.02,
            ),
            const Text(
              "Efficacy",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
            ),
          ],
        ),
      ),
    );
  }
}
