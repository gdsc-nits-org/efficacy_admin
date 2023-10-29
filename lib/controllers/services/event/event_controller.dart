import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_delete_local_impl.dart';
part 'functions/_create_impl.dart';
part 'functions/_check_permission_impl.dart';
part 'functions/_is_any_update_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_delete_impl.dart';

class EventController {
  static const String _collectionName = "events";
  const EventController._();

  static Future<EventModel> _save(EventModel event) async {
    return await _saveImpl(event);
  }

  static Future<void> _deleteLocal(String id) async {
    return await _deleteLocalImpl(id);
  }

  /// If [forEvent] is false it is assumed for the clubEditing
  static Future<void> _checkPermission({
    required String clubID,
    required bool forView,
  }) async {
    return await _checkPermissionImpl(
      clubID: clubID,
      forView: forView,
    );
  }

  /// Assumption: (ClubID, title, startDate, endDate) combination is unique for each event
  static Future<EventModel?> create(EventModel event) async {
    await _checkPermission(
      clubID: event.clubID,
      forView: false,
    );
    return await _createImpl(event);
  }

  //
  static Future<bool> isAnyUpdate(String clubID, DateTime? lastChecked) async {
    return await _isAnyUpdateImpl(clubID, lastChecked);
  }

  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<EventModel>> get({
    String? eventID,
    String? clubID,
    bool forceGet = false,
  }) {
    return _getImpl(
      eventID: eventID,
      clubID: clubID,
      forceGet: forceGet,
    );
  }

  static Future<EventModel> update(EventModel event) async {
    await _checkPermission(
      clubID: event.clubID,
      forView: false,
    );
    return await _updateImpl(event);
  }

  static Future<void> delete(
      {required String eventID, required String clubID}) async {
    await _checkPermission(
      clubID: clubID,
      forView: false,
    );
    return await _deleteImpl(
      eventID: eventID,
      clubID: clubID,
    );
  }
}
