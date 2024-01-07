import 'dart:convert';

import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/local_database/constants.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workmanager/workmanager.dart';
import 'package:efficacy_admin/utils/notification/local_notification.dart';

const String taskDataSync = "dataSync";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case taskDataSync:
        bool canContinue = await _dataSync();
        if (!canContinue) await Workmanager().cancelByUniqueName(taskDataSync);
        break;
    }
    return true;
  });
}

class ForegroundService {
  const ForegroundService._();

  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  static Future<void> startDataSync() async {
    // await Workmanager().cancelByUniqueName(taskDataSync);
    await Workmanager().cancelAll();
    await Workmanager().registerPeriodicTask(
      taskDataSync,
      taskDataSync,
      frequency: const Duration(minutes: 15),
    );
  }
}

/// Returns true if there is a user else returns false
/// False signifies there is no user to sync data so the Workmanager can stop
Future<bool> _dataSync() async {
  if (!dotenv.isInitialized) await dotenv.load();
  await LocalDatabase.init();
  List<String> data = LocalDatabase.get(LocalDocuments.currentUser.name);
  if (data.isNotEmpty) {
    UserModel currentUser = UserModel.fromJson(
        Formatter.convertMapToMapStringDynamic(jsonDecode(data[0]))!);
    await Database.init();
    List<String> clubs = [];
    for (String clubPositionID in currentUser.position) {
      List<ClubPositionModel> pos =
          await ClubPositionController.get(clubPositionID: clubPositionID)
              .first;
      if (pos.isNotEmpty) {
        clubs.addAll(pos.map((p) => p.clubID).toList());
      }
    }
    data = LocalDatabase.get(LocalDocuments.eventCheckpoint.name);
    if (data.isEmpty) {
      return false;
    }
    DateTime previousCheckpoint = DateTime.parse(data[0]);
    await LocalDatabase.set(
      LocalDocuments.eventCheckpoint.name,
      [DateTime.now().toIso8601String()],
    );
    for (String clubID in clubs) {
      if (await EventController.isAnyUpdate(
        clubID,
        previousCheckpoint,
      )) {
        await LocalNotification.sendNotification(
          0,
          "efficacy",
          "update",
          "Efficacy",
          "You have an event update",
        );
        return true;
      }
    }
    return true;
  } else {
    return false;
  }
}
