import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/states/authenticator/authenticator.dart';
import 'package:efficacy_admin/controllers/services/services.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:provider/provider.dart';

class ExperimentPage extends StatefulWidget {
  static const String routeName = "/experimentPage";
  const ExperimentPage({super.key});

  @override
  State<ExperimentPage> createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                GoogleSignInAccount account =
                    await Authenticator.googleSignIn();
                // await UserController.create(user);
                // await LocalDatabase.setUser(user);
              },
              child: const Text("Login with Google"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Authenticator.signOut();
              },
              child: const Text("Login Out"),
            ),
          ].separate(10),
        ),
      ),
    );
  }
}
