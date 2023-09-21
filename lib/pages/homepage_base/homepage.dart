import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
// import 'package:efficacy_admin/pages/homepage_base/events_view.dart';
import 'package:efficacy_admin/pages/homepage_base/tab_list.dart';
import 'package:efficacy_admin/pages/homepage_base/tabView.dart';
import 'package:flutter/material.dart';

class AppHomepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const AppHomepage({super.key});

  @override
  State<AppHomepage> createState() => _AppHomepageState();
}

class _AppHomepageState extends State<AppHomepage> {
  int currentTabIndex = 0;

  navigator(String buttonMessage) {
    setState(() {
      currentTabIndex = tabList.indexOf(buttonMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var activeButton = Provider.of<ActiveButtonState>(context);

    return Column(
      children: [
        AppBar(
          title: const Text(
            "Efficacy",
            style: TextStyle(
              color: Color(0xFF05354C),
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.supervised_user_circle_rounded),
            )
          ],
        ),
        TabView(
          currentTabIndex: currentTabIndex,
          navigator: navigator,
        ),
        // const EventViewer(),
      ].separate(10),
    );
  }
}

//currenttab
//row()
