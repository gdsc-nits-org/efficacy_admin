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
      debugShowCheckedModeBanner: false,
      title: 'Efficacy Admin',
      routes: {
        EventFullScreen.routeName: (context) =>
            const EventFullScreen(), //issue here
        Homepage.routeName: (context) => const Homepage(),
        ExperimentPage.routeName: (BuildContext context) =>
            const ExperimentPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        ClubPage.routeName: (context) => const ClubPage(),
        CreateEvent.routeName: (context) => const CreateEvent(),
        OrganizationsPage.routeName: (context) => const OrganizationsPage()
      },
      builder: ErrorHandler.handle,
      theme: lightTheme,
      initialRoute: SplashScreen.routeName, //ExperimentPage.routeName,
    );
  }
}
