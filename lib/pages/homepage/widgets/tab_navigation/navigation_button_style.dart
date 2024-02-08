import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.message,
    required this.onTap,
    required this.currentTabIndex,
  });

  final EventStatus message;
  final void Function() onTap;
  final int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: (message.name.length * 18.0).toDouble(),
        height: 38,
        child: OutlinedButton(
          onPressed: onTap,
          style: currentTabIndex == EventStatus.values.indexOf(message)
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
            message.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
