import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_check_duplicate_impl.dart';
part 'functions/_check_permission_impl.dart';
part 'functions/_create_impl.dart';
part 'functions/_update_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_get_name_impl.dart';
part 'functions/_list_all_clubs_impl.dart';

class ClubController {
  const ClubController._();
  static const String _collectionName = "clubs";

  static Future<ClubModel> _save(ClubModel club) async {
    return await _saveImpl(club);
  }

  static bool _isMinified(Map<String, dynamic> json) {
    return json[ClubFields.email.name] == null;
  }

  static Future<void> _checkDuplicate(ClubModel club) async {
    return await _checkDuplicateImpl(club);
  }

  static Future<void> _checkPermission({
    required String clubID,
    required bool forView,
  }) async {
    return await _checkPermissionImpl(
      clubID: clubID,
      forView: forView,
    );
  }

  /// Combination of clubName and institute name must be unique
  static Future<ClubModel?> create(ClubModel club) async {
    return await _createImpl(club);
  }

  static Future<ClubModel?> update(ClubModel club) async {
    await _checkPermission(
      clubID: club.id!,
      forView: false,
    );
    return await _updateImpl(club);
  }

  /// For a given id returns all the data of the club
  static Stream<List<ClubModel>> get({
    String? id,
    String? instituteName,
    String? clubName,
    bool forceGet = false,
  }) {
    return _getImpl(
      id: id,
      instituteName: instituteName,
      clubName: clubName,
      forceGet: forceGet,
    );
  }

  /// For a given id returns only the name
  static Stream<String?> getName(String id) {
    return _getNameImpl(id);
  }

  static Future<void> delete(String id) async {
    throw UnimplementedError();
  }

  /// In minified only the club id, name and institute name is returned
  /// Recommended to use minified
  static Stream<List<ClubModel>> listAllClubs({
    List<String> instituteName = const [],
    bool minified = true,
  }) {
    return _listAllClubsImpl(
      instituteName: instituteName,
      minified: minified,
    );
  }
}
