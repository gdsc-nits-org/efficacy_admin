import 'dart:io';
import 'package:efficacy_admin/models/models.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

class LocalDatabase {
  const LocalDatabase._();

  static Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  static Future<dynamic> get(
    LocalCollections collection,
    LocalDocuments key,
  ) async {
    Box box = await Hive.openBox(collection.name);
    return box.get(key.name);
  }

  static Future<void> set(
    LocalCollections collection,
    LocalDocuments key,
    dynamic data,
  ) async {
    Box box = await Hive.openBox(collection.name);
    await box.put(key.name, data);
  }

  static Future<void> deleteKey(
    LocalCollections collection,
    LocalDocuments key,
  ) async {
    Box box = await Hive.openBox(collection.name);
    await box.delete(key.name);
  }

  static Future<void> deleteCollection(LocalCollections collection) async {
    await Hive.deleteBoxFromDisk(collection.name);
  }
}
