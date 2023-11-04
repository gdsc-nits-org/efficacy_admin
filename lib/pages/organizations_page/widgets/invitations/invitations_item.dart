import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

Widget buildInvitationItem(String clubName, String clubPosition) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    decoration: const BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: shadow))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(clubName, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(clubPosition),
          ],
        ),
        Row(
          children: [
            Tooltip(
              message: "Accept",
              child: IconButton(
                onPressed: () {
                  // Handle accept invitation
                  // InvitationController.acceptInvitation();
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            ),
            Tooltip(
              message: "Reject",
              child: IconButton(
                onPressed: () {
                  // Handle reject invitation
                  //InvitationController.rejectInvitation(invitation);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
