part of '../user_controller.dart';

Stream<UserModel?> _loginSilentlyImpl() async* {
  List<String> userData = LocalDatabase.get(LocalDocuments.currentUser.name);
  if (userData.isEmpty) {
    yield null;
  } else {
    UserController.currentUser = UserModel.fromJson(
      Formatter.convertMapToMapStringDynamic(jsonDecode(userData[0]))!,
    );
    await UserController._gatherData();
    yield UserController.currentUser;

    DbCollection collection =
        Database.instance.collection(UserController._collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(UserFields.app.name, appName);
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
