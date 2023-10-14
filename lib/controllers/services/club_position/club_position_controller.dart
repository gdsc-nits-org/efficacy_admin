import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClubPositionController {
  static const String _collectionName = "clubPosition";
  const ClubPositionController._();

  static Future<void> create(ClubPositionModel clubPosition) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    await collection.insert(clubPosition.toJson());
  }

  static Future<List<ClubPositionModel>> get(
      {String? clubPositionID, String? clubID}) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selector = SelectorBuilder();
    if (clubPositionID != null) {
      selector.eq(ClubPositionFields.id.name, clubPositionID);
    } else if (clubID != null) {
      selector.eq(ClubPositionFields.clubID.name, clubID);
    } else {
      throw ArgumentError("Club Position ID or club id is required");
    }

    List<Map<String, dynamic>> res = await collection.find(selector).toList();
    return res.map((model) => ClubPositionModel.fromJson(model)).toList();
  }

  static Future<void> update(ClubPositionModel clubPositionModel) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if ((await get(clubID: clubPositionModel.id?.toHexString())).isEmpty) {
      throw Exception("Couldn't find club position");
    }
    SelectorBuilder selector = SelectorBuilder();
    selector.eq(ClubPositionFields.id.name, clubPositionModel.id);

    await collection.updateOne(selector, clubPositionModel.toJson());
  }

  /// Not implemented as the delete would required cascade event of deleting the members also
  /// Or warning the user
  static Future<void> delete(String clubPositionID) async {
    throw UnimplementedError();
  }
}
