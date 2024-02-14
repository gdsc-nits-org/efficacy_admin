part of '../user_controller.dart';

Future<bool> _doesUserExistsImpl({required String email}) async {
  List<UserModel> user = await UserController.get(email: email, forceGet: true).first;
  return user.isNotEmpty;
}