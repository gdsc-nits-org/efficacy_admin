part of '../user_controller.dart';

Future<void> _gatherDataImpl({required bool forceGet}) async {
  if (UserController.currentUser == null) return;

  List<String> positions = UserController.currentUser!.position;
  UserController.clubPositions = [];
  for (String id in positions) {
    UserController.clubPositions.addAll(
      await ClubPositionController.get(
        clubPositionID: id,
        forceGet: forceGet,
      ).first,
    );
  }
  UserController.clubs = [];
  for (ClubPositionModel position in UserController.clubPositions) {
    UserController.clubs.addAll(await ClubController.get(
      id: position.clubID,
      forceGet: forceGet,
    ).first);
  }
  return;
}
