part of '../invitation_controller.dart';

Future<void> _checkPermissionImpl(String clubPositionID) async {
  ClubPositionModel clubPosition =
      (await ClubPositionController.get(clubPositionID: clubPositionID).first)
          .first;
  List<ClubModel> club =
      await ClubController.get(id: clubPosition.clubID, forceGet: true).first;
  if (club.isEmpty) {
    throw Exception("Club doesn't exists");
  }
  if (club.first.members.isEmpty) {
    return;
  }
  int index = UserController.clubPositions.indexWhere(
    (position) => position.clubID == clubPosition.clubID,
  );
  if (index == -1) {
    throw Exception("User doesn't belong to the club");
  }
  if (!UserController.clubPositions[index].permissions
      .contains(Permissions.modifyMembers)) {
    throw Exception("You do not have permission to add members to the club");
  }
}
