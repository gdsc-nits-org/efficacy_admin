import 'package:efficacy_admin/config/configurations/theme/utils/palette.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:flutter/material.dart';

class ContactsDropDown extends StatefulWidget {
  final List<UserModel> items;
  final UserModel? value;
  final String? title;
  final void Function(UserModel?)? onChanged;
  final TextEditingController? controller;
  const ContactsDropDown({
    super.key,
    required this.items,
    this.value,
    this.title,
    this.onChanged,
    this.controller,
  });

  @override
  State<ContactsDropDown> createState() => _ContactsDropDownState();
}

class _ContactsDropDownState extends State<ContactsDropDown> {
  UserModel? currentlySelected;

  @override
  void initState() {
    super.initState();
    currentlySelected = widget.value;
    if (currentlySelected == null && widget.items.isNotEmpty) {
      currentlySelected = widget.items.first;
    }
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
        DropdownButton<UserModel>(
          dropdownColor: paleBlue,
          isExpanded: false,
          value: currentlySelected,
          items: widget.items.map((UserModel moderator) {
            return DropdownMenuItem<UserModel>(
              value: moderator,
              child: Text(moderator.name),
            );
          }).toList(),
          onChanged: (UserModel? newValue) {
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
