// import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/cupertino.dart';

class Contributors extends StatelessWidget {
  Contributors({super.key, 
  required this.contacts,
  required this.role});
  List<String> contacts;
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
        Column(
          children: contacts.map((e) => Text(e)).toList()
        )
      ],
    );
  }
}
