import 'package:flutter/material.dart';

class CustomDropMenu extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final void Function(String?) onChanged;

  const CustomDropMenu({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
