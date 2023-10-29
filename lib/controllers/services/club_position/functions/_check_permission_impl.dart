part of '../club_position_controller.dart';

/// If [forView] is true it checks for the permission if the user can view it
/// Basically if the user is in the club
///
/// If [forView] is false it is assumed the permission to check is for editing a position
Future<void> _checkPermissionImpl({
  required String clubID,
  required bool forView,
}) async {
  List<ClubModel> club =
      await ClubController.get(id: clubID, forceGet: true).first;
  if (club.isEmpty) {
    throw Exception("Club doesn't exists");
  }
  if (club.first.members.isEmpty) {
    return;
  }
  List<ClubPositionModel> positions = UserController.clubPositions
      .where((clubPosition) => clubPosition.clubID == clubID)
      .toList();
  for (ClubPositionModel position in positions) {
    if (position.clubID == clubID) {
      if (forView == true) {
        return;
      } else if (forView == false &&
          position.permissions.contains(Permissions.modifyClub)) {
        return;
      }
    }
  }
  throw Exception("User does not have permission to create events");
}
