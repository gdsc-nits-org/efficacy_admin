import 'dart:convert';

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
part 'functions/_get_all_events_impl.dart';
part 'functions/_like_impl.dart';

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

  /// Returns all the events.
  /// Can be used for pagination
  ///
  /// Pass [prevPassed] as page number and
  /// [count] as max number of events to be returned
  ///
  /// The [prevPassed] is used in terms of the updatedAt parameter
  ///
  /// If [clubIDs] is not provided it returns for all the clubs.
  static Stream<EventPaginationResponse> getAllEvents({
    int skip = 0,
    List<String?> clubIDs = const [],
    bool forceGet = false,
    int count = 10,
  }) {
    return _getAllEventsImpl(
      skip: skip,
      clubIDs: clubIDs,
      forceGet: forceGet,
      count: count,
    );
  }

  static Future<EventModel> toggleLike(
      {required String userEmail, required EventModel event}) async {
    return _toggleLikeImpl(userEmail: userEmail, event: event);
  }
}

class EventPaginationResponse {
  final int skip;
  final List<EventModel> events;
  const EventPaginationResponse(this.skip, this.events);

  @override
  String toString() {
    return 'EventPaginationResponse(skip: $skip, events: $events)';
  }
}
