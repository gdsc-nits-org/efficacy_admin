import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final String? title;
  final bool enabled;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  const CustomDropDown({
    super.key,
    this.controller,
    this.items = const [],
    this.value,
    this.enabled = true,
    this.title,
    this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? currentlySelected;

  @override
  void initState() {
    super.initState();
    currentlySelected = widget.value;
    if (currentlySelected == null && widget.items.isNotEmpty) {
      currentlySelected = widget.items.first;
    }
  }

  String? getCurrentlySelected() {
    return currentlySelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        DropdownButton(
          dropdownColor: paleBlue,
          isExpanded: true,
          value: currentlySelected,
          items: widget.items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: widget.enabled == false
              ? null
              : (String? newValue) {
                  setState(() {
                    currentlySelected = newValue!;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(newValue);
                  }
                },
        ),
      ],
    );
  }
}
