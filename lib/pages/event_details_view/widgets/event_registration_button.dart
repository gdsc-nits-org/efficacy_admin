import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class EventRegistrationButton extends StatelessWidget {
  const EventRegistrationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.message,
    this.width = 160,
    this.height = 35,
  });
  final double width;
  final double height;
  final Function onTap;
  final Widget icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      // width: (message.length * 17.0).toDouble(),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: icon,
        label: Text(

          message,
          style: const TextStyle(
            fontSize: 12,
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
