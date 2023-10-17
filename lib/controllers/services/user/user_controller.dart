import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/utils/database/constants.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/encrypter.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/constants.dart';
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
      } else {
        currentUser = currentUser!.copyWith(lastLocalUpdate: DateTime.now());
        await LocalDatabase.set(
          LocalCollections.user,
          LocalDocuments.currentUser,
          currentUser!.toJson(),
        );
      }
    }
    user = user!.copyWith(lastLocalUpdate: DateTime.now());
    Map? res =
        await LocalDatabase.get(LocalCollections.user, LocalDocuments.users);
    res ??= {};
    res[user.email] = user.toJson();
    await LocalDatabase.set(LocalCollections.user, LocalDocuments.users, res);
    return user;
  }

  static UserModel _removePassword(UserModel user) {
    return user.copyWith(password: "");
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

    if (await get(user.email, forceGet: true).first != null) {
      throw Exception("User exists with the provided email. Please Log in");
    } else {
      user = user.copyWith(
        password: Encryptor.encrypt(
          user.password,
          dotenv.env[EnvValues.ENCRYPTER_SALT.name]!,
        ),
      );
      await collection.insert(user.toJson());
      currentUser = await get(user.email, forceGet: true).first;
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
  static Future<UserModel?> login(String email, String password) async {
    UserModel? user =
        await get(email, keepPassword: true, forceGet: true).first;
    if (user == null) {
      throw Exception("User exists with the provided email. Please Log in");
    } else {
      if (!Encryptor.isValid(user.password, password)) {
        throw Exception("Invalid password");
      }
      user = _removePassword(user);
      currentUser = user;
      currentUser = await _save();
      return currentUser;
    }
  }

  /// Log in without internet i.e. from local database
  ///   * If returns null means the user data was not stored
  ///   * Returns the UserModel if exists
  ///   * Stores the user data in currentUser
  static Future<UserModel?> loginSilently() async {
    dynamic userData = await LocalDatabase.get(
        LocalCollections.user, LocalDocuments.currentUser);
    if (userData == null) {
      return null;
    }
    Map<String, dynamic> data = {};
    for (dynamic key in userData.keys) {
      data[key] = userData[key];
    }
    return currentUser = UserModel.fromJson(data);
  }

  /// Fetches a  user from the provided email
  ///   * if keepPassword is true, the hashed password is kept (recommended not to keep)
  ///   * if keepPassword is false, the hashed password is replaced with ""
  ///
  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<UserModel?> get(
    String email, {
    bool keepPassword = false,
    bool forceGet = false,
  }) async* {
    if (forceGet) {
      await LocalDatabase.deleteCollection(LocalCollections.user);
    } else {
      Map? users =
          await LocalDatabase.get(LocalCollections.user, LocalDocuments.users);
      if (users != null && users.containsKey(email)) {
        yield UserModel.fromJson(
          Formatter.convertMapToMapStringDynamic(users[email])!,
        );
      }
    }

    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(UserFields.email.name, email);
    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res != null) {
      UserModel user = UserModel.fromJson(res);
      if (!keepPassword) {
        user = _removePassword(user);
      }
      user = (await _save(user: user)) ?? user;
      yield user;
    } else {
      yield null;
    }
  }

  /// Updates the user data if exists in the database
  /// and stores it in the local database
  ///
  /// Current user is not set as the update might not be necessarily of the current user
  static Future<UserModel?> update(UserModel user) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if (await get(user.email, forceGet: true).first == null) {
      throw Exception("Couldn't find user");
    } else {
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq(UserFields.email.name, user.email);
      await collection.update(
        selectorBuilder,
        user.toJson(),
      );
      user = (await _save(user: user)) ?? user;
      return user;
    }
  }

  /// Deletes the user if exists from both local database and server
  static Future<void> delete(String email) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if (await get(email, forceGet: true).first == null) {
      throw Exception("Couldn't find user");
    } else {
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq(UserFields.email.name, email);
      await collection.deleteOne(selectorBuilder);

      await logOut();
    }
  }

  static Future<void> logOut() async {
    currentUser = null;
    await _save();
  }
}
