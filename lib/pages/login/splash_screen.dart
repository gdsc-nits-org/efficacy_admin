import 'dart:async';
import 'package:efficacy_admin/config/config.dart';

import 'package:efficacy_admin/pages/login/welcome_page.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  //route
  static const String routeName = "/splashscreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// TODO: Implement error handling
  Future<void> init() async {
    await dotenv.load();
    // await Database.init();
    await LocalDatabase.init();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //screen height and width
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    //size constants
    final double avatarRadius = width * 0.25;
    final double gap = height * 0.03;

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
              "Efficacy",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ].separate(gap),
        ),
      ),
    );
  }
}
