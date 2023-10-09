import 'package:flutter/material.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_tabs_setup/tab_list.dart';

class NavButton extends StatelessWidget {
  const NavButton({
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
    return Container(
      width: (message.length * 17.0).toDouble(),
      height: 38,
      child: OutlinedButton(
        onPressed: onTap,
        style: currentTabIndex == tabList.indexOf(message)
            ? OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF05354C),
                foregroundColor: const Color(0xFFEDF9FF),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFF05354C),
                    width: 50,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              )
            : OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF05354C),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color(0xFF05354C),
                    width: 50,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
        child: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
