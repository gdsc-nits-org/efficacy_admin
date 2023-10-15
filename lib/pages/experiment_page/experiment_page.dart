import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/club/club_controller.dart';
import 'package:efficacy_admin/controllers/services/services.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/local_database/constants.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter/material.dart';
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
                // await EventController.create(
                //   EventModel(
                //     posterURL: "1",
                //     title: "1",
                //     shortDescription: "1",
                //     startDate: DateTime.parse("2023-10-15T19:05:27.949457"),
                //     endDate: DateTime.parse("2023-10-15T19:05:27.949457"),
                //     registrationLink: "1",
                //     venue: "1",
                //     contacts: [],
                //     clubID: "1",
                //   ),
                // );
                // await EventController.create(
                //   EventModel(
                //     posterURL: "2",
                //     title: "2",
                //     shortDescription: "1",
                //     startDate: DateTime.now(),
                //     endDate: DateTime.now(),
                //     registrationLink: "1",
                //     venue: "1",
                //     contacts: [],
                //     clubID: "2",
                //   ),
                // );
                // await EventController.create(
                //   EventModel(
                //     posterURL: "1",
                //     title: "3",
                //     shortDescription: "1",
                //     startDate: DateTime.now(),
                //     endDate: DateTime.now(),
                //     registrationLink: "1",
                //     venue: "1",
                //     contacts: [],
                //     clubID: "2",
                //   ),
                // );
                // await EventController.create(
                //   EventModel(
                //     posterURL: "1",
                //     title: "4",
                //     shortDescription: "1",
                //     startDate: DateTime.now(),
                //     endDate: DateTime.now(),
                //     registrationLink: "1",
                //     venue: "1",
                //     contacts: [],
                //     clubID: "3",
                //   ),
                // );
                // await EventController.create(
                //   EventModel(
                //     posterURL: "1",
                //     title: "5",
                //     shortDescription: "1",
                //     startDate: DateTime.now(),
                //     endDate: DateTime.now(),
                //     registrationLink: "1",
                //     venue: "1",
                //     contacts: [],
                //     clubID: "1",
                //   ),
                // );
                // await EventController.create(
                //   EventModel(
                //     posterURL: "1",
                //     title: "1",
                //     shortDescription: "1",
                //     startDate: DateTime.now(),
                //     endDate: DateTime.now(),
                //     registrationLink: "1",
                //     venue: "1",
                //     contacts: [],
                //     clubID: "3",
                //   ),
                // );
              },
              child: const Text("Login with Google"),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text("Log Out"),
            ),
          ].separate(10),
        ),
      ),
    );
  }
}
