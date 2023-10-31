// import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/cupertino.dart';

class Contributors extends StatelessWidget {
  const Contributors({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          role,
          style: const TextStyle(
            color: dark,
            fontSize: 25,
          ),
        ),
        Text("person 1"),
        Text("person 2"),
        Text("person 3"),
        Text("person 4"),
        Text("person 5"),
      ],
    );
  }
}
