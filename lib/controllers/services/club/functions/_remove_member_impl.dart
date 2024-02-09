part of '../club_controller.dart';

Future<void> _removeMemberImpl({
  required String memberEmail,
  required ClubPositionModel position,
}) async {
  if (UserController.clubWithModifyMemberPermission
      .where((club) => club.id == position.clubID)
      .isNotEmpty) {
    List<UserModel> user =
        await UserController.get(email: memberEmail, forceGet: true).first;
    if (user.isEmpty) {
      throw Exception("User not found");
    }
    List<ClubModel> club =
        await ClubController.get(id: position.clubID, forceGet: true).first;
    if (club.isEmpty) {
      throw Exception("Club not found");
    }
    Map<String, List<String>> members =
        Map<String, List<String>>.from(club.first.members);
    members[position.id]?.remove(memberEmail);
    club[0] = club[0].copyWith(members: members);
    await ClubController.update(club[0]);

    List<String> userPositions = List<String>.from(user.first.position);
    userPositions.remove(position.id);
    user[0] = user[0].copyWith(position: userPositions);
    await UserController.update(updatedUser: user[0]);
  } else {
    throw Exception("User does not have permission to remove members");
  }
}
