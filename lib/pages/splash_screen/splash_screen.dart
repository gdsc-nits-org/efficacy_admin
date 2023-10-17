import 'dart:async';
import 'dart:io';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/database/database.dart';
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
  // Function to process all async functions
  Future<int> init() async {
    Stopwatch stopwatch = Stopwatch()..start();
    await dotenv.load();
    await Database.init();
    await LocalDatabase.init();
    stopwatch.stop();
    return stopwatch.elapsed.inMilliseconds;
  }

  @override
  void initState() {
    super.initState();
    init().then((duration) {
      debugPrint("Successfully completed all async tasks");
      debugPrint("Time taken: $duration ms");

      Navigator.pushNamed(context, LoginPage.routeName)
          .then((value) => exit(0));
    });
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
