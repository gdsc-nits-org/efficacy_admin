part of '../user_controller.dart';

Future<UserModel?> _updateImpl({UserModel? user}) async {
  if (UserController.currentUser == null && user == null) {
    throw Exception("Please Login");
  }
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);

  String? oldUserEmail;
  UserModel newUser = user ?? UserController.currentUser!;
  if (user == null) {
    oldUserEmail = UserController.currentUser!.email;
  } else {
    oldUserEmail = user.email;
  }
  List<UserModel> oldData = await UserController.get(
    email: oldUserEmail,
    forceGet: true,
  ).first;
  if (oldData.isEmpty) {
    throw Exception("Couldn't find user");
  } else {
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(UserFields.app.name, appName);
    selectorBuilder.eq(UserFields.email.name, oldUserEmail);
    await collection.updateOne(
      selectorBuilder,
      compare(
        oldData.first.toJson(),
        newUser.toJson(),
        ignore: [UserFields.password.name, UserFields.email.name],
      ).map,
    );
    newUser = (await UserController._save(user: newUser))!;
    if (user == null) {
      UserController.currentUser = newUser;
    }
    return newUser;
  }
}
