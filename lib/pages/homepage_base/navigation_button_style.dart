import 'package:flutter/material.dart';
import 'package:efficacy_admin/pages/homepage_base/tab_list.dart';

class NavButton extends StatelessWidget {
  NavButton({
    super.key,
    required this.message,
    required this.onTap,
    required this.currentTabIndex,
  });

  final String message;
  final void Function() onTap;
  final int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    // var activeButton = Provider.of<ActiveButtonState>(context);

    return OutlinedButton(
      onPressed: onTap,
      style: currentTabIndex == tabList.indexOf(message)
          ? OutlinedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 12, 90, 126),
              foregroundColor: const Color(0xFFEDF9FF),
            )
          : OutlinedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 12, 90, 126),
              backgroundColor: const Color(0xFFEDF9FF),
            ),
      child: Text(message),
    );
  }
}
