part of '../club_controller.dart';

Future<void> _acceptClubImpl({required String clubID}) async {
  UserModel? currentUser = UserController.currentUser;
  if (currentUser == null) {
    throw Exception("Please login again.");
  }
  AppInfoModel appInfo = await AppInfoController.get();
  if (!appInfo.adminEmails.contains(currentUser.email)) {
    throw Exception("You do not have enough privilege for the operation.");
  }

  List<ClubModel> club =
      await ClubController.get(id: clubID, forceGet: true).first;
  if (club.isEmpty) {
    throw Exception("Club not found.");
  }
  if (club.first.clubStatus == ClubStatus.accepted) {
    throw Exception("Club was already accepted by developers.");
  } else if (club.first.clubStatus == ClubStatus.rejected) {
    throw Exception("Club was rejected by developers.");
  }

  club.first = club.first.copyWith(clubStatus: ClubStatus.accepted);

  await ClubController.update(club.first, internalUpdate: true);
}
