part of '../user_controller.dart';

Future<void> _deleteImpl() async {
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);

  if (UserController.currentUser == null) {
    throw Exception("Please Login to your account");
  }
  if ((await UserController.get(
              email: UserController.currentUser!.email, forceGet: true)
          .first)
      .isEmpty) {
    throw Exception("Couldn't find user");
  } else {
    SelectorBuilder selectorBuilder = SelectorBuilder();
    for (ClubModel club in UserController.clubs) {
      Map<String, List<String>> members = club.members;

      // Improve Later
      for (MapEntry<String, List<String>> memberList in members.entries) {
        memberList.value.remove(UserController.currentUser!.id);
      }
      await ClubController.update(club.copyWith(members: members));
    }
    selectorBuilder.eq(
      UserFields.email.name,
      UserController.currentUser!.email,
    );
    await collection.deleteOne(selectorBuilder);

    await UserController.logOut();
  }
}
