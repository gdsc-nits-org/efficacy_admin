import 'package:flutter/cupertino.dart';

class StatsInfo extends StatelessWidget {
  const StatsInfo({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Text(
        message,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
