import 'dart:io';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

class LocalDatabase {
  static Box? _userBox;
  const LocalDatabase._();

  static Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  static Future<UserModel?> getUser() async {
    _userBox ??= await Hive.openBox(LocalCollections.user.name);
    return UserModel.fromJson(_userBox!.get(LocalDocuments.currentUser.name));
  }

  static Future<void> setUser(UserModel user) async {
    _userBox ??= await Hive.openBox(LocalCollections.user.name);
    // Since at all time we will have only 1 signed in user.
    await _userBox!.delete(LocalDocuments.currentUser.name);
    print("hh");
    await _userBox!.put(LocalDocuments.currentUser.name, user.toJson());
    print("added");
  }
}
