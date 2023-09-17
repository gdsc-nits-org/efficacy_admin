import 'package:efficacy_admin/pages/homepage_base/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavButton extends StatelessWidget {
  NavButton({
    super.key,
    required this.message,
    required this.onTap,
    required this.isActive,
  });

  final String message;
  final Function onTap;
  final bool isActive;

  // void onPressedButton() {
  //   callback(activeStateBool);
  // }

  @override
  Widget build(BuildContext context) {
    // var activeButton = Provider.of<ActiveButtonState>(context);

    return OutlinedButton(
      onPressed: onTap(),
      style: isActive
          ? OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF05354C),
              foregroundColor: const Color(0xFFEDF9FF),
            )
          : null,
      child: Text(message),
    );
  }
}
