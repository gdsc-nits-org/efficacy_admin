import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final String? title;
  final bool enabled;
  final void Function(String?)? onItemChanged;
  final TextEditingController? controller;
  const CustomDropDown({
    super.key,
    this.controller,
    this.items = const [],
    this.initialValue,
    this.enabled = true,
    this.title,
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
    currentlySelected = widget.initialValue;
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
        DropdownButtonFormField(
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
                  if (widget.onItemChanged != null) {
                    widget.onItemChanged!(newValue);
                  }
                },
        ),
      ],
    );
  }
}
