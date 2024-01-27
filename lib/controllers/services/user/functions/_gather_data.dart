part of '../user_controller.dart';

Future<void> _gatherDataImpl({required bool forceGet}) async {
  if (UserController.currentUser == null) return;

  List<String> positions = UserController.currentUser!.position;
  Set<ClubPositionModel> clubPositions = {};
  for (String id in positions) {
    clubPositions.addAll(
      await ClubPositionController.get(
        clubPositionID: id,
        forceGet: forceGet,
      ).first,
    );
  }

  UserController.clubPositions = clubPositions.toList();

  Set<ClubModel> clubs = {};
  Set<ClubModel> clubWithModifyEventPermission = {};
  Set<ClubModel> clubWithModifyMemberPermission = {};
  Set<ClubModel> clubWithModifyClubPermission = {};
  for (ClubPositionModel position in UserController.clubPositions) {
    List<ClubModel> club = await ClubController.get(
      id: position.clubID,
      forceGet: forceGet,
    ).first;
    clubs.addAll(club);
    if (position.permissions.contains(Permissions.modifyEvents)) {
      clubWithModifyEventPermission.addAll(club);
    }
    if (position.permissions.contains(Permissions.modifyMembers)) {
      clubWithModifyMemberPermission.addAll(club);
    }
    if (position.permissions.contains(Permissions.modifyClub)) {
      clubWithModifyClubPermission.addAll(club);
    }
  }
  UserController.clubs = clubs.toList();
  UserController.clubWithModifyEventPermission =
      clubWithModifyEventPermission.toList();
  UserController.clubWithModifyMemberPermission =
      clubWithModifyMemberPermission.toList();
  UserController.clubWithModifyClubPermission =
      clubWithModifyClubPermission.toList();
  return;
}
