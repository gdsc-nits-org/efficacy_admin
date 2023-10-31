part of '../user_controller.dart';

Future<UserModel?> _saveImpl({UserModel? user}) async {
  // If the user provided is null it assumes that it wants to save the currentUser
  if (user == null) {
    user = UserController.currentUser;
    if (UserController.currentUser == null) {
      await LocalDatabase.deleteCollection(LocalCollections.user);
      return null;
    } else {
      UserController.currentUser =
          UserController._removePassword(UserController.currentUser!);
      UserController.currentUser =
          UserController.currentUser!.copyWith(lastLocalUpdate: DateTime.now());
      await LocalDatabase.set(
        LocalCollections.user,
        LocalDocuments.currentUser,
        UserController.currentUser!.toJson(),
      );
    }
  }
  user = UserController._removePassword(user!);
  user = user.copyWith(lastLocalUpdate: DateTime.now());
  Map? res = await LocalDatabase.get(
    LocalCollections.user,
    LocalDocuments.users,
  );
  res ??= {};
  res[user.email] = user.toJson();
  await LocalDatabase.set(
    LocalCollections.user,
    LocalDocuments.users,
    res,
  );
  return user;
}
