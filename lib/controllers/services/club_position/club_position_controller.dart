import 'dart:convert';

import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_check_duplicate_impl.dart';
part 'functions/_check_permission_impl.dart';
part 'functions/_create_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_delete_impl.dart';

class ClubPositionController {
  static const String _collectionName = "clubPosition";
  const ClubPositionController._();

  static Future<ClubPositionModel> _save(
    ClubPositionModel position, {
    bool delete = false,
  }) async {
    return await _saveImpl(position, delete: delete);
  }

  static Future<void> _checkDuplicate(ClubPositionModel clubPosition) async {
    return await _checkDuplicateImpl(clubPosition);
  }

  static Future<void> _checkPermission({
    required String clubID,
    required bool forView,
  }) async {
    return _checkPermissionImpl(
      clubID: clubID,
      forView: forView,
    );
  }

  /// Assumption: Combination of clubID and position is unique
  static Future<ClubPositionModel?> create(
      ClubPositionModel clubPosition) async {
    await _checkPermission(
      clubID: clubPosition.clubID,
      forView: false,
    );
    return await _createImpl(clubPosition);
  }

  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<ClubPositionModel>> get({
    String? clubPositionID,
    String? clubID,
    bool forceGet = false,
  }) {
    return _getImpl(
      clubID: clubID,
      clubPositionID: clubPositionID,
      forceGet: forceGet,
    );
  }

  static Future<ClubPositionModel> update(
      ClubPositionModel clubPositionModel) async {
    await _checkPermission(
      clubID: clubPositionModel.clubID,
      forView: false,
    );
    return await _updateImpl(clubPositionModel);
  }

  /// Not implemented as the delete would required cascade event of deleting the members also
  /// Or warning the user
  static Future<void> delete(ClubPositionModel clubPositionModel) async {
    await _checkPermissionImpl(
      clubID: clubPositionModel.clubID,
      forView: false,
    );
    await _deleteImpl(clubPositionModel);
    await _save(
      clubPositionModel,
      delete: true,
    );
  }
}
