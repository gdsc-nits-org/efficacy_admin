import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'utils/utils.dart';
import 'config/config.dart';
import 'pages/pages.dart';

void main() async {
  runApp(
    BetterFeedback(
      theme: FeedbackThemeData(
        activeFeedbackModeColor: accent,
        colorScheme: const ColorScheme.light(
          primary: accent,
          secondary: accent,
        ),
      ),
      child: const EfficacyAdmin(),
    ),
  );
}

class EfficacyAdmin extends StatelessWidget {
  const EfficacyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Efficacy Admin',
      routes: {
        //issue here
        Homepage.routeName: (context) => const Homepage(),
        ExperimentPage.routeName: (BuildContext context) =>
            const ExperimentPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        ClubPage.routeName: (context) => const ClubPage(),
        ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
        CreateUpdateEvent.routeName: (context) => const CreateUpdateEvent(),
        OrganizationsPage.routeName: (context) => const OrganizationsPage(),
        DevelopersPage.routeName: (context) => const DevelopersPage(),
        InvitePage.routeName: (context) => const InvitePage(),
      },
      builder: ErrorHandler.handle,
      theme: lightTheme,
      initialRoute: SplashScreen.routeName, //ExperimentPage.routeName,
    );
  }
}
