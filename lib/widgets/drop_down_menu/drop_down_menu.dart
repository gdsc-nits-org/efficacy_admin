import 'package:efficacy_admin/widgets/drop_down_menu/drop_down.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  DropDown dropDown = DropDown();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: isSelected
          ? const Color.fromRGBO(159, 220, 249, 1)
          : const Color.fromRGBO(237, 249, 255, 1),
      isExpanded: true,
      value: dropDown.dropdownvalue,
      items: dropDown.items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropDown.dropdownvalue = newValue!;
          isSelected = true;
        });
      },
    );
  }
}
