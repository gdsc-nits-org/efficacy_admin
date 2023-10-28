import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/constants.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClubPositionController {
  static const String _collectionName = "clubPosition";
  const ClubPositionController._();

  static Future<ClubPositionModel> _save(ClubPositionModel position) async {
    Map? positions = await LocalDatabase.get(
        LocalCollections.clubPosition, LocalDocuments.clubPositions);
    positions ??= {};
    position = position.copyWith(lastLocalUpdate: DateTime.now());
    positions[position.id] = position.toJson();
    await LocalDatabase.set(
      LocalCollections.clubPosition,
      LocalDocuments.clubPositions,
      positions,
    );
    return position;
  }

  /// Assumption: Combination of clubID and position is unique
  static Future<ClubPositionModel?> create(
      ClubPositionModel clubPosition) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(ClubPositionFields.clubID.name, clubPosition.clubID);
    selectorBuilder.eq(ClubPositionFields.position.name, clubPosition.position);
    if (await collection.findOne(selectorBuilder) != null) {
      throw Exception("Club already has a position with the same name");
    }

    await collection.insertOne(clubPosition.toJson());
    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res == null) return null;
    clubPosition = ClubPositionModel.fromJson(res);
    clubPosition = await _save(clubPosition);
    return clubPosition;
  }

  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<ClubPositionModel>> get(
      {String? clubPositionID, String? clubID, bool forceGet = false}) async* {
    List<ClubPositionModel> filteredClubPositions = [];
    SelectorBuilder selector = SelectorBuilder();
    if (clubPositionID != null) {
      selector.eq("_id", ObjectId.parse(clubPositionID));
    } else if (clubID != null) {
      selector.eq(ClubPositionFields.clubID.name, clubID);
    } else {
      throw ArgumentError("Club Position ID or club id is required");
    }

    if (forceGet) {
      await LocalDatabase.deleteKey(
        LocalCollections.clubPosition,
        LocalDocuments.clubPositions,
      );
    } else {
      Map? res = await LocalDatabase.get(
        LocalCollections.clubPosition,
        LocalDocuments.clubPositions,
      );
      if (res != null) {
        if (clubPositionID != null && res.containsKey(clubPositionID)) {
          yield [
            ClubPositionModel.fromJson(
              Formatter.convertMapToMapStringDynamic(res[clubPositionID])!,
            )
          ];
        } else if (clubID != null) {
          for (dynamic model in res.values) {
            model = Formatter.convertMapToMapStringDynamic(model);
            if (model[ClubPositionFields.clubID.name] == clubID) {
              filteredClubPositions.add(ClubPositionModel.fromJson(model));
            }
          }
          if (filteredClubPositions.isNotEmpty) yield filteredClubPositions;
        }
      }
    }
    DbCollection collection = Database.instance.collection(_collectionName);

    List<Map<String, dynamic>> res = await collection.find(selector).toList();
    filteredClubPositions =
        res.map((model) => ClubPositionModel.fromJson(model)).toList();
    for (int i = 0; i < filteredClubPositions.length; i++) {
      filteredClubPositions[i] = await _save(filteredClubPositions[i]);
    }
    yield filteredClubPositions;
  }

  static Future<ClubPositionModel> update(
      ClubPositionModel clubPositionModel) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    List<ClubPositionModel> oldData =
        await get(clubID: clubPositionModel.id, forceGet: true).first;
    if (oldData.isEmpty) {
      throw Exception("Couldn't find club position");
    }
    SelectorBuilder selector = SelectorBuilder();
    selector.eq("_id", ObjectId.parse(clubPositionModel.id!));

    await collection.updateOne(
      selector,
      compare(oldData.first.toJson(), clubPositionModel.toJson()).map,
    );
    return await _save(clubPositionModel);
  }

  /// Not implemented as the delete would required cascade event of deleting the members also
  /// Or warning the user
  static Future<void> delete(String clubPositionID) async {
    throw UnimplementedError();
  }
}
