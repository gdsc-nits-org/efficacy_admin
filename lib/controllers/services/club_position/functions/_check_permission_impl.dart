part of '../club_position_controller.dart';

/// If [forView] is true it checks for the permission if the user can view it
/// Basically if the user is in the club
///
/// If [forView] is false it is assumed the permission to check is for editing a position
Future<void> _checkPermissionImpl({
  required String clubPositionID,
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
  if (club.first.leadPositionID == clubPositionID) {
    throw Exception("Leader position cannot be updated or deleted.");
  }
  List<ClubPositionModel> positions = UserController.clubPositions
      .where((clubPosition) => clubPosition.clubID == clubID)
      .toList();

  for (ClubPositionModel position in positions) {
    if (forView == true) {
      return;
    } else if (forView == false &&
        !position.permissions.contains(Permissions.modifyClub)) {
      throw Exception("User does not have permission to modify club");
    }
  }
}
