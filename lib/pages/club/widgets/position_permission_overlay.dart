import 'dart:math';

import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

class ClubPositionPermissionOverlay extends StatefulWidget {
  final ClubPositionModel clubPosition;
  final ClubModel? club;
  const ClubPositionPermissionOverlay({super.key, required this.clubPosition,required this.club});

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
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    const Spacer(flex: 1),
                    CustomTextField(
                      controller: _nameController,
                      enabled: true,
                      title: "Club Position",
                    ),
                    const Spacer(flex: 1),
                    const Text('Position Permissions:'),
                    Column(
                      children: Permissions.values.map((permission) {
                        return CheckboxListTile(
                          enabled: widget.clubPosition.id != widget.club!.leadPositionID,
                          contentPadding: EdgeInsets.zero,
                          title: Tooltip(
                            message: permission.description,
                            child: Row(
                              children: [
                                Tooltip(
                                  message: permission.description,
                                  triggerMode: TooltipTriggerMode.tap,
                                  child: const Icon(
                                    Icons.info,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  permission.name,
                                  maxLines: null,
                                )),
                              ],
                            ),
                          ),
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
                            onPressed:widget.clubPosition.id != widget.club!.leadPositionID ? () async {

                                showLoadingOverlay(
                                    parentContext: context,
                                    asyncTask: () async {
                                      await ClubPositionController.delete(
                                        widget.clubPosition,
                                      );
                                      Navigator.pop(context, null);
                                    });


                            } : null,
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
                              showLoadingOverlay(
                                  parentContext: context,
                                  asyncTask: () async {
                                    ClubPositionModel updatedPosition =
                                        widget.clubPosition.copyWith(
                                            position: _nameController.text
                                                .trim()
                                                .toString(),
                                            permissions: _selectedPermissions);
                                    await ClubPositionController.update(
                                        updatedPosition);
                                    await UserController.updateUserData();
                                    Navigator.pop(context, updatedPosition);
                                  });
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
