import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  //route
  static const String routeName = "/WelcomePage";

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
            //circle avatar which will show the user's profile pic
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
              radius: myWidth * 0.25,
              child: const SizedBox(),
            ),
            SizedBox(
              height: myHeight * 0.05,
            ),
            //welcome message
            const Text(
              "Hey! Welcome",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
            SizedBox(
              height: myHeight * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suscipit sed augue quam amet, sed gravida.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17, color: Colors.black.withOpacity(0.65)),
              ),
            ),
            SizedBox(
              height: myHeight * 0.1,
            ),
            //sign in with google button
            InkWell(
                onTap: () {},
                child: Image.asset(
                    "assets/images/btn_google_signin_light_normal_web@2x 1.png"))
          ],
        ),
      ),
    );
  }
}
