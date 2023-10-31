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
      title: 'Flutter Demo',
      routes: {
        EventFullScreen.routeName: (context) =>
            const EventFullScreen(), //issue here
        Homepage.routeName: (context) => const Homepage(),
        ExperimentPage.routeName: (BuildContext context) =>
            const ExperimentPage(),
        LoginPage.routeName: (context) =>  LoginPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SignUpUserDetailsPage.routeName: (context) => const SignUpUserDetailsPage(),
        CreateEvent.routeName: (context) => const CreateEvent(),
        OrganizationsPage.routeName:(context) => const OrganizationsPage()
      },
      builder: ErrorHandler.handle,
      theme: lightTheme,
      initialRoute: SplashScreen.routeName,      //ExperimentPage.routeName,
    );
  }
}
