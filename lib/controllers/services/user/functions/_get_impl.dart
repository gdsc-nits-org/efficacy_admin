part of '../user_controller.dart';

Stream<List<UserModel>> _getImpl({
  String? email,
  String? id,
  String? nameStartsWith,
  bool keepPassword = false,
  bool forceGet = false,
}) async* {
  if (nameStartsWith == null && email == null && id == null) {
    throw ArgumentError("Email or NameStartsWith or id must be provided");
  }

  List<UserModel> filteredModels = await _fetchLocal(
    email: email,
    id: id,
    nameStartsWith: nameStartsWith,
    keepPassword: keepPassword,
    forceGet: forceGet,
  );
  if (filteredModels.isNotEmpty) yield filteredModels;

  filteredModels = await _fetchFromBackend(
    email: email,
    id: id,
    nameStartsWith: nameStartsWith,
    keepPassword: keepPassword,
    forceGet: forceGet,
  );
  yield filteredModels;
}

Future<List<UserModel>> _fetchLocal({
  String? email,
  String? id,
  String? nameStartsWith,
  bool keepPassword = false,
  bool forceGet = false,
}) async {
  List<UserModel> filteredUsers = [];
  if (forceGet) {
    await LocalDatabase.deleteKey(LocalDocuments.users.name);
  } else if (keepPassword == false) {
    // Since passwords are never stored in the local database
    List<String> data = LocalDatabase.get(LocalDocuments.users.name);
    if (data.isNotEmpty) {
      Map users = jsonDecode(data[0]);
      if (email != null) {
        if (users.containsKey(email)) {
          UserModel user = UserModel.fromJson(
            Formatter.convertMapToMapStringDynamic(users[email])!,
          );
          if (user.app == appName) {
            filteredUsers.add(user);
          }
        }
      } else if (nameStartsWith != null) {
        for (dynamic user in users.values) {
          if (user != null &&
              (user[UserFields.name.name] as String)
                  .toLowerCase()
                  .startsWith(nameStartsWith.toLowerCase()) &&
              (user[UserFields.app.name] as String) == appName) {
            filteredUsers.add(UserModel.fromJson(
              Formatter.convertMapToMapStringDynamic(user)!,
            ));
          }
        }
      } else if (id != null) {
        for (dynamic user in users.values) {
          if (user != null &&
              user["id"] == id.toString() &&
              (user[UserFields.app.name] as String) == appName) {
            filteredUsers.add(UserModel.fromJson(
              Formatter.convertMapToMapStringDynamic(user)!,
            ));
            break;
          }
        }
      }
    }
  }

  return filteredUsers;
}

Future<List<UserModel>> _fetchFromBackend({
  String? email,
  String? id,
  String? nameStartsWith,
  bool keepPassword = false,
  bool forceGet = false,
}) async {
  // Backend
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(UserFields.app.name, appName);
  if (nameStartsWith != null) {
    selectorBuilder.match(
      UserFields.name.name,
      nameStartsWith,
      caseInsensitive: true,
    );
  } else if (email != null) {
    selectorBuilder.limit(1);
    selectorBuilder.eq(UserFields.email.name, email);
  } else if (id != null) {
    selectorBuilder.limit(1);
    selectorBuilder.eq("_id", ObjectId.parse(id));
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
