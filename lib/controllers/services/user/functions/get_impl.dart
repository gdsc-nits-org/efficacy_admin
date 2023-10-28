part of '../user_controller.dart';

Stream<List<UserModel>> getImpl({
  String? email,
  String? nameStartsWith,
  bool keepPassword = false,
  bool forceGet = false,
}) async* {
  if (nameStartsWith == null && email == null) {
    throw ArgumentError("Email or NameStartsWith must be provided");
  }

  List<UserModel> filteredModels = await _fetchLocal(
    email: email,
    nameStartsWith: nameStartsWith,
    keepPassword: keepPassword,
    forceGet: forceGet,
  );
  if (filteredModels.isNotEmpty) yield filteredModels;

  filteredModels = await _fetchFromBackend(
    email: email,
    nameStartsWith: nameStartsWith,
    keepPassword: keepPassword,
    forceGet: forceGet,
  );
  yield filteredModels;
}

Future<List<UserModel>> _fetchLocal({
  String? email,
  String? nameStartsWith,
  bool keepPassword = false,
  bool forceGet = false,
}) async {
  List<UserModel> filteredUsers = [];
  if (forceGet) {
    await LocalDatabase.deleteCollection(LocalCollections.user);
  } else if (keepPassword == false) {
    // Since passwords are never stored in the local database
    Map users = await LocalDatabase.get(
          LocalCollections.user,
          LocalDocuments.users,
        ) ??
        {};
    if (email != null) {
      if (users.containsKey(email)) {
        filteredUsers.add(
          UserModel.fromJson(
              Formatter.convertMapToMapStringDynamic(users[email])!),
        );
      }
    } else {
      for (dynamic user in users.values) {
        if (user != null &&
            (user[UserFields.name.name] as String)
                .toLowerCase()
                .startsWith(nameStartsWith!.toLowerCase())) {
          filteredUsers.add(UserModel.fromJson(
            Formatter.convertMapToMapStringDynamic(user)!,
          ));
        }
      }
    }
  }

  return filteredUsers;
}

Future<List<UserModel>> _fetchFromBackend({
  String? email,
  String? nameStartsWith,
  bool keepPassword = false,
  bool forceGet = false,
}) async {
  // Backend
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  if (nameStartsWith != null) {
    selectorBuilder.match(
      UserFields.name.name,
      nameStartsWith,
      caseInsensitive: true,
    );
  } else {
    selectorBuilder.limit(1);
    selectorBuilder.eq(UserFields.email.name, email);
  }
  List<Map<String, dynamic>> res =
      await collection.find(selectorBuilder).toList();

  List<UserModel> users = [];
  for (Map<String, dynamic> userData in res) {
    UserModel user = UserModel.fromJson(userData);
    String? password;
    if (keepPassword) {
      password = user.password;
    }
    user = (await UserController._save(user: user))!;
    users.add(user.copyWith(password: password));
  }
  return users;
}
