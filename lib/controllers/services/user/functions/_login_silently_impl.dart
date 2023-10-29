part of '../user_controller.dart';

Stream<UserModel?> _loginSilentlyImpl() async* {
  dynamic userData = await LocalDatabase.get(
    LocalCollections.user,
    LocalDocuments.currentUser,
  );
  if (userData == null) {
    yield null;
  } else {
    yield UserController.currentUser = UserModel.fromJson(
      Formatter.convertMapToMapStringDynamic(userData)!,
    );

    DbCollection collection =
        Database.instance.collection(UserController._collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(
        UserFields.email.name, UserController.currentUser!.email);
    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res != null) {
      UserModel user = UserModel.fromJson(res);
      UserController.currentUser = await UserController._save(user: user);
      yield UserController.currentUser;
    } else {
      yield null;
    }
    await UserController._gatherData();
  }
}
