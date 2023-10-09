import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_tabs_setup/navigation_button_style.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_tabs_setup/tab_list.dart';
import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  const TabView({
    super.key,
    required this.currentTabIndex,
    required this.navigator,
  });

  final int currentTabIndex;
  final Function navigator;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          NavButton(
            message: tabList[0],
            onTap: () => navigator(tabList[0]),
            currentTabIndex: currentTabIndex,
          ),
          NavButton(
            message: tabList[1],
            onTap: () => navigator(tabList[1]),
            currentTabIndex: currentTabIndex,
          ),
          NavButton(
            message: tabList[2],
            onTap: () => navigator(tabList[2]),
            currentTabIndex: currentTabIndex,
          ),
        ].separate(12),
      ),
    );
  }
}
