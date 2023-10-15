import 'dart:io';
import 'package:efficacy_admin/models/models.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

/// The data is assumed to be either directly as a json value
/// Or a list of json value
/// Or a Map of json value
///
/// Each value must contain lastLocalUpdate
/// Neccessary for removing stale data
class LocalDatabase {
  static const Duration _staleDataDuration = Duration(days: 7);
  const LocalDatabase._();

  static Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await _removeStaleData();
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
    if (await Hive.boxExists(collection.name)) {
      Box box = await Hive.openBox(collection.name);
      await box.delete(key.name);
    }
  }

  static Future<void> deleteCollection(LocalCollections collection) async {
    await Hive.deleteBoxFromDisk(collection.name);
  }

  static bool _canKeepData(Map? item) {
    if (item == null) return false;
    DateTime oldDate = DateTime.parse(item[UserFields.lastLocalUpdate.name]);
    return DateTime.now().difference(oldDate) < _staleDataDuration;
  }

  static Future<void> _removeStaleDataFromBox(
      LocalCollections collection) async {
    Box box = await Hive.openBox(collection.name);

    for (dynamic key in box.keys) {
      print(key);
      dynamic data = await box.get(key);
      dynamic filteredData;
      print(data);
      if (data is Map && data.values.isNotEmpty && data.values.first is Map) {
        filteredData = {};
        for (dynamic key in data.keys) {
          Map? item = data[key];
          if (_canKeepData(item)) {
            filteredData[key] = item;
          }
        }
      } else if (data is List) {
        filteredData = [];
        for (Map item in data) {
          if (_canKeepData(item)) {
            filteredData.add(item);
          }
        }
      } else {
        if (_canKeepData(data)) {
          filteredData = data;
        }
      }
      print(filteredData);
      box.delete(key);
      if (filteredData != null) {
        if (filteredData is Map || filteredData is List) {
          if (filteredData.isNotEmpty) await box.put(key, filteredData);
        } else {
          await box.put(key, filteredData);
        }
      }
    }
  }

  static Future<void> _removeStaleData() async {
    for (LocalCollections collection in LocalCollections.values) {
      await _removeStaleDataFromBox(collection);
    }
  }
}
