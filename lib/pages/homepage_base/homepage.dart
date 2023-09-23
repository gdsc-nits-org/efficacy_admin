import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/pages/homepage_base/event_display_setup/events_view.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_tabs_setup/tab_list.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_tabs_setup/tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHomepage extends StatefulWidget {
  static const String routeName = "/homePage";
  const AppHomepage({super.key});

  @override
  State<AppHomepage> createState() => _AppHomepageState();
}

class _AppHomepageState extends State<AppHomepage> {
  int currentTabIndex = 0;

  void navigator(String buttonMessage) {
    setState(() {
      currentTabIndex = tabList.indexOf(buttonMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            AppBar(
              title: const Text(
                "Efficacy",
                style: TextStyle(
                  color: Color(0xFF05354C),
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            TabView(
              currentTabIndex: currentTabIndex,
              navigator: navigator,
            ),
            EventViewer(
              typeIndex: currentTabIndex,
            ),
            Visibility(
              visible: currentTabIndex == 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: () {}, //define add event function here
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            )
          ].separate(26),
        ),
      ),
    );
  }
}
