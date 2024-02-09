part of '../club_position_controller.dart';

Future<void> _deleteImpl(ClubPositionModel clubPosition) async {
  DbCollection collection =
      Database.instance.collection(ClubPositionController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(clubPosition.id!));

  List<ClubModel> club =
      await ClubController.get(id: clubPosition.clubID, forceGet: true).first;
  if (club.isEmpty) {
    throw Exception("Club not found");
  }
  Map<String, List<String>> members =
      Map<String, List<String>>.from(club[0].members);

  List<String> users = members[clubPosition.id] ?? [];
  for (String userEmail in users) {
    List<UserModel> user =
        await UserController.get(email: userEmail, forceGet: true).first;
    if (user.length == 1) {
      List<String> updatedPositions = List<String>.from(user[0].position);
      updatedPositions.remove(clubPosition.id);
      user[0] = user[0].copyWith(position: updatedPositions);

      await UserController.update(updatedUser: user[0]);
    }
  }

  members.remove(clubPosition.id);
  club[0] = club[0].copyWith(members: members);

  await ClubController.update(club[0]);
  await collection.deleteOne(selectorBuilder);
}
