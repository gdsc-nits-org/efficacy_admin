part of '../user_controller.dart';

Future<UserModel?> _updateImpl() async {
  if (UserController.currentUser == null) {
    throw Exception("Please Login");
  }
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);

  List<UserModel> oldData = await UserController.get(
    email: UserController.currentUser!.email,
    forceGet: true,
  ).first;
  if (oldData.isEmpty) {
    throw Exception("Couldn't find user");
  } else {
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(
        UserFields.email.name, UserController.currentUser!.email);
    await collection.updateOne(
      selectorBuilder,
      compare(
        oldData.first.toJson(),
        UserController.currentUser!.toJson(),
        ignore: [UserFields.password.name, UserFields.email.name],
      ).map,
    );
    UserController.currentUser =
        (await UserController._save(user: UserController.currentUser))!;
    return UserController.currentUser;
  }
}
