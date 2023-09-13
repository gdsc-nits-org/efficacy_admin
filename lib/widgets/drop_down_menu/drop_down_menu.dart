import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownvalue = 'GDSC';

  // List of items in our dropdown menu
  var items = [
    'GDSC',
    'Eco Club',
    'Item 3',
    'Item 4',
  ];

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: isSelected
          ? const Color.fromRGBO(159, 220, 249, 1)
          : const Color.fromRGBO(237, 249, 255, 1),
      isExpanded: true,
      value: dropdownvalue,
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
          isSelected = true;
        });
      },
    );
  }
}
