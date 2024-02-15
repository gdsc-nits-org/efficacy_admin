import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

class ConfirmRemoveMember extends StatelessWidget {
  final String memberEmail;
  final UserModel? member;
  final ClubPositionModel clubPosition;
  const ConfirmRemoveMember({
    super.key,
    this.member,
    required this.memberEmail,
    required this.clubPosition,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double fieldHeight = height * 0.09;

    return AlertDialog(
      title: const Text('Confirm Removing Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'Are you sure that you want to remove ${member?.name ?? memberEmail} ?'),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            showLoadingOverlay(
              parentContext: context,
              asyncTask: () async {
                await ClubController.removeMember(
                  memberEmail: memberEmail,
                  position: clubPosition,
                );
                await UserController.gatherData();
                showSnackBar(context, "User removed");
                Navigator.pop(context, true);
              },
            );
          },
          child: const Text('Confirm', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
