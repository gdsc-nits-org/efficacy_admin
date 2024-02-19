import 'dart:async';
import 'dart:io';
import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
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
  bool isDatabaseInitSuccess = false;
  bool isLocalInitSuccess = false;
  // Function to process all async functions
  Future<int> init() async {
    Stopwatch stopwatch = Stopwatch()..start();
    await dotenv.load();
    isDatabaseInitSuccess = await Database.init();
    isLocalInitSuccess = await LocalDatabase.init();
    // await ForegroundService.init();
    // await ForegroundService.startDataSync();
    if (isDatabaseInitSuccess && isLocalInitSuccess) {
      await UserController.loginSilently().last;
    }
    stopwatch.stop();
    return stopwatch.elapsed.inMilliseconds;
  }

  @override
  void initState() {
    super.initState();
    init().then((duration) {
      debugPrint("Successfully completed all async tasks");
      debugPrint("Time taken: $duration ms");
      if (UserController.currentUser == null &&
          isDatabaseInitSuccess &&
          isLocalInitSuccess) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(
                LoginPage.routeName, (Route<dynamic> route) => false)
            .then((value) => exit(0));
      } else if (isDatabaseInitSuccess && isLocalInitSuccess) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(
                Homepage.routeName, (Route<dynamic> route) => false)
            .then((value) => exit(0));
      } else {
        showSnackBar(
            context, "Unknown error occured. Please contact developers");
      }
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
              "Efficacy Admin",
              style: Theme.of(context).textTheme.displayMedium,
              maxLines: null,
            ),
          ].separate(gap),
        ),
      ),
    );
  }
}
