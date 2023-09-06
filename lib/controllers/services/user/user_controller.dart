import 'package:efficacy_admin/states/authenticator/authenticator.dart';
import 'package:efficacy_admin/models/user/user_model.dart';

class UserController {
  const UserController._();

  static Future<void> create(UserModel user) async {
    await update(user);
  }

  static Future<UserModel?> get() async {
    throw UnimplementedError("Implement fetch User");
  }

  static Future<void> update(UserModel user) async {
    // throw UnimplementedError("Implement update User");
  }

  static Future<void> delete() async {
    throw UnimplementedError();
  }
}
