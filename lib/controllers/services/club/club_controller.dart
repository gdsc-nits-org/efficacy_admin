import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClubController {
  const ClubController._();
  static const String _collectionName = "clubs";

  static Future<void> create(ClubModel club) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    await collection.insert(club.toJson());
  }

  static Future<void> update(ClubModel club) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if (club.id == null || await get(club.id!) == null) {
      throw Exception("Couldn't find club");
    } else {
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq("id", club.id);
      await collection.update(selectorBuilder, club.toJson());
    }
  }

  /// For a given id returns all the data of the club
  static Future<ClubModel?> get(String id) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(ClubFields.id.name, id);

    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
    if (res != null) {
      return ClubModel.fromJson(res);
    }
    return null;
  }

  /// For a given id returns only the name
  static Future<String?> getName(String id) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(ClubFields.id.name, id);
    selectorBuilder.fields([ClubFields.name.name]);

    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
    if (res != null) {
      return res[ClubFields.name.name];
    }
    return null;
  }

  static Future<void> delete(String id) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    if (await get(id) == null) {
      throw Exception("Couldn't find club");
    } else {
      SelectorBuilder selectorBuilder = SelectorBuilder();
      selectorBuilder.eq("id", id);
      await collection.deleteOne(selectorBuilder);
    }
  }

  /// In minified only the club id, name and institute name is returned
  /// Recommended to use minified
  static Future<List<ClubModel>> listAllClubs(List<String> instituteName,
      {bool minified = true}) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    if (minified) {
      selectorBuilder.fields([
        ClubFields.id.name,
        ClubFields.name.name,
        ClubFields.instituteName.name,
      ]);
    }

    if (instituteName.isNotEmpty) {
      selectorBuilder.nin(ClubFields.instituteName.name, instituteName);
    }

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();
    List<ClubModel> models = [];
    for (Map<String, dynamic> val in res) {
      models.add(
        ClubModel(
          id: val[ClubFields.id.name],
          name: val[ClubFields.name.name],
          instituteName: val[ClubFields.instituteName.name],
          description: val[ClubFields.description.name] ?? "",
          socials: val[ClubFields.socials.name] ?? {},
          email: val[ClubFields.email.name] ?? "",
          phoneNumber: val[ClubFields.phoneNumber.name],
          clubLogoURL: val[ClubFields.clubLogoURL.name] ?? "",
          clubBannerURL: val[ClubFields.clubBannerURL.name] ?? "",
          members: val[ClubFields.members.name] ?? {},
          followers: val[ClubFields.followers.name] ?? [],
        ),
      );
    }
    return models;
  }
}
