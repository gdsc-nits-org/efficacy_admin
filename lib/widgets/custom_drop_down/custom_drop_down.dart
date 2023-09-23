import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String? currentlySelected;
  final void Function(String?)? onItemChanged;
  const CustomDropDown({
    super.key,
    this.items = const [],
    this.currentlySelected,
    this.onItemChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? currentlySelected;

  @override
  void initState() {
    super.initState();
    currentlySelected = widget.currentlySelected;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: paleBlue,
      isExpanded: true,
      value: currentlySelected,
      items: widget.items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          currentlySelected = newValue!;
        });
        if (widget.onItemChanged != null) {
          widget.onItemChanged!(newValue);
        }
      },
    );
  }
}
