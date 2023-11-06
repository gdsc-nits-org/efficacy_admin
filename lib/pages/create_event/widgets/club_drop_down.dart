import 'package:efficacy_admin/config/configurations/theme/utils/palette.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:flutter/material.dart';

class ClubDropDown extends StatefulWidget {
  final List<ClubModel> items;
  final ClubModel? value;
  final String? title;
  final void Function(ClubModel?)? onChanged;
  final TextEditingController? controller;
  const ClubDropDown({
    super.key,
    required this.items,
    this.value,
    this.title,
    this.onChanged,
    this.controller,
  });

  @override
  State<ClubDropDown> createState() => _ClubDropDownState();
}

class _ClubDropDownState extends State<ClubDropDown> {
  ClubModel? currentlySelected;

  @override
  void initState() {
    super.initState();
    currentlySelected = widget.value;
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
        DropdownButton<ClubModel>(
          dropdownColor: paleBlue,
          isExpanded: false,
          value: currentlySelected,
          items: widget.items.map((ClubModel club) {
            return DropdownMenuItem<ClubModel>(
              value: club,
              child: Text(club.name),
            );
          }).toList(),
          onChanged: (ClubModel? newValue) {
            if (newValue != null) {
              setState(() {
                currentlySelected = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            }
          },
        ),
      ],
    );
  }
}
