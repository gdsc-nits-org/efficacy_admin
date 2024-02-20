part of '../user_controller.dart';

Future<bool> _isCurrentUserAnAdminImpl() async {
  UserModel? currentUser = UserController.currentUser;
  if (currentUser == null) {
    throw Exception("Please login again.");
  }
  AppInfoModel appInfo = await AppInfoController.get();
  return appInfo.adminEmails.contains(currentUser.email);
}
