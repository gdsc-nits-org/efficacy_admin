import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {},
              child: const Text("Task 1"),
            ),
            ElevatedButton(
              onPressed: () async {
                throw Exception("Expected exception");
              },
              child: const Text("Log Out"),
            ),
          ].separate(1000),
        ),
      ),
    );
  }
}
