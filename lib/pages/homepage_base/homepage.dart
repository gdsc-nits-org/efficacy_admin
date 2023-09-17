import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/pages/homepage_base/events_view.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_button_style.dart';
import 'package:efficacy_admin/pages/homepage_base/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHomepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const AppHomepage({super.key});

  @override
  State<AppHomepage> createState() => _AppHomepageState();
}

class _AppHomepageState extends State<AppHomepage> {
  navigator(bool activeButton) {
    setState(() {
      activeButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeButton = Provider.of<ActiveButtonState>(context);

    return Column(
      children: [
        AppBar(
          title: const Text(
            "Efficacy",
            style: TextStyle(
              color: Color(0xFF05354C),
            ),
            // textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.supervised_user_circle_rounded),
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              NavButton(
                message: 'Upcoming',
                // callback: navigator,
              ),
              NavButton(
                message: 'Ongoing',
                // callback: navigator,
              ),
              NavButton(
                message: 'Completed',
                // callback: navigator,
              ),
            ].separate(3),
          ),
        ),
        const EventViewer(),
      ].separate(10),
    );
  }
}
