import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class EventRegistrationButton extends StatelessWidget {
  const EventRegistrationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.message,
  });

  final Function onTap;
  final Widget icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: (message.length * 17.0).toDouble(),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: icon,
        label: Text(
          message,
          style: const TextStyle(
            color: dark,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: light,
        ),
      ),
    );
  }
}
