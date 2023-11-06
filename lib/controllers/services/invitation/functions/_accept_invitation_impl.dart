part of '../invitation_controller.dart';

Future<void> _acceptInvitationImpl(String invitationID) async {
  if (UserController.currentUser == null) {
    throw Exception("Please Login");
  }

  // Gathering the required data
  // If anything is not found or is invalid it throws an exception
  List<InvitationModel> invitations =
      await InvitationController.get(invitationID: invitationID).last;

  if (invitations.isEmpty) {
    throw Exception("Invitation expired");
  }
  if (UserController.currentUser!.id != invitations.first.recipientID) {
    throw Exception("Permission Denied");
  }
  List<ClubPositionModel> clubPosition = await ClubPositionController.get(
    clubPositionID: invitations.first.clubPositionID,
  ).first;
  if (clubPosition.isEmpty) {
    throw Exception("Invalid Club Position");
  }
  List<ClubModel> clubs = await ClubController.get(
    id: clubPosition.first.clubID,
    forceGet: true,
  ).first;
  if (clubs.isEmpty) {
    throw Exception("Club not found");
  }

  // Accepting the invitation and updating the data
  ClubModel club = clubs.first;
  Map<String, List<String>> members = Map.of(club.members);
  if (!members.containsKey(clubPosition.first.id)) {
    members[clubPosition.first.id!] = [];
  }
  members[clubPosition.first.id!]!.add(UserController.currentUser!.email);
  club = club.copyWith(members: members);
  List<String> position = List.of(UserController.currentUser!.position);
  position.add(clubPosition.first.id!);
  UserController.currentUser =
      UserController.currentUser!.copyWith(position: position);

  // Updating the data in the backend
  await Future.wait([
    ClubController.update(club),
    UserController.update(),
    InvitationController.delete(invitations.first),
  ]);
}
