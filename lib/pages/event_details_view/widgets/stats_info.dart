import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/cupertino.dart';

class StatsInfo extends StatelessWidget {
  const StatsInfo({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.75,
      child: Text(
        message,
        style: const TextStyle(fontSize: 15, color: dark),
      ),
    );
  }
}
