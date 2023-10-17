import 'package:flutter/material.dart';

//moderator class
class Moderator {
  String name;

  Moderator(this.name);
}


class CustomDropMenu extends StatelessWidget {
  final List<DropdownMenuItem<Moderator>> items;
  final Moderator? value;
  final void Function(Moderator?) onChanged;

  const CustomDropMenu({super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Moderator>(
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
