import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/utils/database/constants.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/encrypter.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_create_impl.dart';
part 'functions/_login_impl.dart';
part 'functions/_login_silently_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_delete_impl.dart';

class UserController {
  static const String _collectionName = "users";
  static UserModel? currentUser;
  const UserController._();

  /// Pass user as null if you want to save the currentUser
  static Future<UserModel?> _save({UserModel? user}) async {
    return await _saveImpl(user: user);
  }

  static UserModel _removePassword(UserModel user) {
    return user.copyWith(password: null);
  }

  /// Checks for duplicate values
  /// If found throws error
  static Future<void> _checkDuplicate(UserModel user) async {
    if ((await get(email: user.email, forceGet: true).first).isNotEmpty) {
      throw Exception("User exists with the provided email. Please Log in");
    }
  }

  /// Crates a user
  ///  * If user exists throws exception
  ///  * Hashes the password
  ///  * If user doesn't exist creates it
  ///
  /// Stores the value in local database
  /// Stores the value in currentUser field
  static Future<UserModel?> create(UserModel user) async {
    return await _createImpl(user);
  }

  /// Logs in the user
  ///  * If user exists throws exception
  ///  * If password doesn't match throws exception
  ///
  /// Stores the value in local database
  /// Stores the value in currentUser field
  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    return await _loginImpl(
      email: email,
      password: password,
    );
  }

  /// Log in without internet i.e. from local database
  ///   * If returns null means the user data was not stored
  ///   * Returns the UserModel if exists
  ///   * Stores the user data in currentUser
  static Stream<UserModel?> loginSilently() {
    return _loginSilentlyImpl();
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
  }) {
    return _getImpl(
      email: email,
      nameStartsWith: nameStartsWith,
      keepPassword: keepPassword,
      forceGet: forceGet,
    );
  }

  /// Updates the user data if exists in the database
  /// and stores it in the local database
  ///
  /// It updates the data of the currentUser
  static Future<UserModel?> update() async {
    return await _updateImpl();
  }

  /// Deletes the user if exists from both local database and server
  static Future<void> delete() async {
    return await _deleteImpl();
  }

  static Future<void> logOut() async {
    currentUser = null;
    await _save();
  }
}
