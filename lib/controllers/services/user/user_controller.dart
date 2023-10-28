import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/utils/database/constants.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/encrypter.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserController {
  static const String _collectionName = "users";
  static UserModel? currentUser;
  const UserController._();

  static Future<UserModel?> _save({UserModel? user}) async {
    if (user == null) {
      user = currentUser;
      if (currentUser == null) {
        await LocalDatabase.deleteCollection(LocalCollections.user);
        return null;
      } else {
        currentUser = _removePassword(currentUser!);
        currentUser = currentUser!.copyWith(lastLocalUpdate: DateTime.now());
        await LocalDatabase.set(
          LocalCollections.user,
          LocalDocuments.currentUser,
          currentUser!.toJson(),
        );
      }
    }
    user = _removePassword(user!);
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

  static UserModel _removePassword(UserModel user) {
    return user.copyWith(password: null);
  }

  /// Crates a user
  ///  * If user exists throws exception
  ///  * Hashes the password
  ///  * If user doesn't exist creates it
  ///
  /// Stores the value in local database
  /// Stores the value in currentUser field
  static Future<UserModel?> create(UserModel user) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if ((await get(email: user.email, forceGet: true).first).isNotEmpty) {
      throw Exception("User exists with the provided email. Please Log in");
    }

    if (user.password == null || user.password!.isEmpty) {
      throw Exception("Password cannot be empty");
    } else {
      user = user.copyWith(
        password: Encryptor.encrypt(
          user.password!,
          dotenv.env[EnvValues.ENCRYPTER_SALT.name]!,
        ),
      );
      await collection.insertOne(user.toJson());
      currentUser = (await get(email: user.email, forceGet: true).first).first;
      currentUser = await _save();
      return currentUser;
    }
  }

  /// Logs in the user
  ///  * If user exists throws exception
  ///  * If password doesn't match throws exception
  ///
  /// Stores the value in local database
  /// Stores the value in currentUser field
  static Future<UserModel?> login(
      {required String email, required String password}) async {
    List<UserModel> user = await get(
      email: email,
      keepPassword: true,
      forceGet: true,
    ).first;
    if (user.isEmpty) {
      throw Exception("User exists with the provided email. Please Log in");
    } else if (user.first.password == null) {
      throw Exception(
        "There has been some issue in the backend related to your data. Please contact the developers",
      );
    } else {
      if (!Encryptor.isValid(user.first.password!, password)) {
        throw Exception("Invalid password");
      }
      currentUser = user.first;
      currentUser = await _save();
      return currentUser;
    }
  }

  /// Log in without internet i.e. from local database
  ///   * If returns null means the user data was not stored
  ///   * Returns the UserModel if exists
  ///   * Stores the user data in currentUser
  static Stream<UserModel?> loginSilently() async* {
    dynamic userData = await LocalDatabase.get(
      LocalCollections.user,
      LocalDocuments.currentUser,
    );
    if (userData == null) {
      yield null;
    } else {
      yield currentUser = UserModel.fromJson(
        Formatter.convertMapToMapStringDynamic(userData)!,
      );

      DbCollection collection = Database.instance.collection(_collectionName);
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq(UserFields.email.name, currentUser!.email);
      Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

      if (res != null) {
        UserModel user = UserModel.fromJson(res);
        currentUser = await _save(user: user);
        yield currentUser;
      } else {
        yield null;
      }
    }
  }

  /// Fetches a  user from the provided email
  ///   * if keepPassword is true, the hashed password is kept (recommended not to keep)
  ///   * if keepPassword is false, the hashed password is replaced with ""
  ///
  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<UserModel>> get({
    String? email,
    String? nameStartsWith,
    bool keepPassword = false,
    bool forceGet = false,
  }) async* {
    if (nameStartsWith == null && email == null) {
      throw ArgumentError("Email or NameStartsWith must be provided");
    }

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
          yield [
            UserModel.fromJson(
              Formatter.convertMapToMapStringDynamic(users[email])!,
            )
          ];
        }
      } else {
        List<UserModel> filteredUsers = [];
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
        if (filteredUsers.isNotEmpty) {
          yield filteredUsers;
        }
      }
    }
    DbCollection collection = Database.instance.collection(_collectionName);
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
      user = (await _save(user: user))!;
      users.add(user.copyWith(password: password));
    }
    yield users;
  }

  /// Updates the user data if exists in the database
  /// and stores it in the local database
  ///
  /// Current user is not set as the update might not be necessarily of the current user
  static Future<UserModel?> update(UserModel user) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    List<UserModel> oldData =
        await get(email: user.email, forceGet: true).first;
    if (oldData.isEmpty) {
      throw Exception("Couldn't find user");
    } else {
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq(UserFields.email.name, user.email);
      await collection.updateOne(
        selectorBuilder,
        compare(
          oldData.first.toJson(),
          user.toJson(),
          ignore: [UserFields.password.name],
        ).map,
      );
      user = (await _save(user: user))!;
      return user;
    }
  }

  /// Deletes the user if exists from both local database and server
  static Future<void> delete() async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if (currentUser == null) {
      throw Exception("Please Login to your account");
    }
    if ((await get(email: currentUser!.email, forceGet: true).first).isEmpty) {
      throw Exception("Couldn't find user");
    } else {
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq(UserFields.email.name, currentUser!.email);
      await collection.deleteOne(selectorBuilder);

      await logOut();
    }
  }

  static Future<void> logOut() async {
    currentUser = null;
    await _save();
  }
}
