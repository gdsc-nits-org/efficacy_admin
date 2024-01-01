import 'dart:math';

import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class ClubPositionPermissionOverlay extends StatefulWidget {
  final ClubPositionModel clubPosition;
  const ClubPositionPermissionOverlay({super.key, required this.clubPosition});

  @override
  State<ClubPositionPermissionOverlay> createState() =>
      _ClubPositionPermissionOverlayState();
}

class _ClubPositionPermissionOverlayState
    extends State<ClubPositionPermissionOverlay> {
  final TextEditingController _nameController = TextEditingController();
  List<Permissions> _selectedPermissions = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.clubPosition.position;
    _selectedPermissions = List.from(widget.clubPosition.permissions);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: min(400, size.width * .8),
        height: min(400 * 1.5, size.height * .8),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 1),
                    CustomTextField(
                      controller: _nameController,
                      enabled: true,
                      title: _nameController.text.toString(),
                    ),
                    const Spacer(flex: 1),
                    const Text('Position Permissions:'),
                    Column(
                      children: Permissions.values.map((permission) {
                        return CheckboxListTile(
                          title: Text(permission.name),
                          value: _selectedPermissions.contains(permission),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  _selectedPermissions.add(permission);
                                } else {
                                  _selectedPermissions.remove(permission);
                                }
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Flexible(
                          flex: 4,
                          fit: FlexFit.loose,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () {
                              ClubPositionController.delete(
                                  widget.clubPosition.id!);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Flexible(
                          flex: 4,
                          fit: FlexFit.loose,
                          child: ElevatedButton(
                            onPressed: () {
                              ClubPositionController.update(widget.clubPosition
                                  .copyWith(
                                      position: _nameController.text
                                          .trim()
                                          .toString(),
                                      permissions: _selectedPermissions));
                              Navigator.pop(context);
                            },
                            child: const Text('Update'),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            )));
  }
}
