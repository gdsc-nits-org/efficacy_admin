import 'package:flutter/material.dart';
import 'utils/utils.dart';
import 'config/config.dart';
import 'pages/pages.dart';

void main() async {
  runApp(const EfficacyAdmin());
}

class EfficacyAdmin extends StatelessWidget {
  const EfficacyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        ExperimentPage.routeName: (BuildContext context) =>
            const ExperimentPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
      },
      builder: ErrorHandler.handle,
      theme: lightTheme,
      initialRoute: ProfilePage.routeName,
      //ExperimentPage.routeName,
    );
  }
}
