part of '../invitation_controller.dart';

Future<void> _checkIfUserIsAlreadyInThatPositionImpl(
    InvitationModel invitation) async {
  List<UserModel> user = await UserController.get(
    id: invitation.recipientID,
    forceGet: true,
  ).first;
  if (user.isEmpty) {
    throw Exception("Invalid recipient");
  }
  if (user.first.position.contains(invitation.clubPositionID)) {
    throw Exception("Recipient is already in that position");
  }
}
