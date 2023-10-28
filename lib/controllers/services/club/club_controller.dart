import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClubController {
  const ClubController._();
  static const String _collectionName = "clubs";

  static Future<ClubModel> _save(ClubModel club) async {
    Map? clubs = await LocalDatabase.get(
      LocalCollections.club,
      LocalDocuments.clubs,
    );
    clubs ??= {};
    club = club.copyWith(lastLocalUpdate: DateTime.now());
    clubs[club.id] = club.toJson();
    await LocalDatabase.set(
      LocalCollections.club,
      LocalDocuments.clubs,
      clubs,
    );
    return club;
  }

  static bool _isMinified(Map<String, dynamic> json) {
    return json[ClubFields.email.name] == null;
  }

  static Future<void> _checkDuplicate(ClubModel club) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(ClubFields.instituteName.name, club.instituteName);
    selectorBuilder.eq(ClubFields.name.name, club.name);

    if (await collection.findOne(selectorBuilder) != null) {
      throw Exception("Club with same name exists at ${club.instituteName}");
    }
  }

  /// Combination of clubName and institute name must be unique
  static Future<ClubModel?> create(ClubModel club) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(ClubFields.instituteName.name, club.instituteName);
    selectorBuilder.eq(ClubFields.name.name, club.name);

    await _checkDuplicate(club);
    await collection.insertOne(club.toJson());
    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res == null) return null;
    club = ClubModel.fromJson(res);
    club = await _save(club);
    return club;
  }

  static Future<ClubModel?> update(ClubModel club) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    if (club.id == null) {
      throw Exception("Couldn't find club");
    }
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq("_id", ObjectId.parse(club.id!));

    List<ClubModel> oldData = await get(id: club.id, forceGet: true).first;

    if (oldData.isEmpty) {
      throw Exception("Couldn't find club");
    } else {
      if (oldData.first.instituteName != club.instituteName ||
          oldData.first.name != club.name) {
        await _checkDuplicate(club);
      }
      await collection.update(
        selectorBuilder,
        compare(
          oldData.first.toJson(),
          club.toJson(),
        ).map,
      );
      club = await _save(club);
      return club;
    }
  }

  /// For a given id returns all the data of the club
  static Stream<List<ClubModel>> get({
    String? id,
    String? instituteName,
    String? clubName,
    bool forceGet = false,
  }) async* {
    List<ClubModel> filteredClubs = [];
    SelectorBuilder selectorBuilder = SelectorBuilder();
    if (id != null) {
      selectorBuilder.eq("_id", ObjectId.parse(id));
    }
    if (instituteName != null) {
      selectorBuilder.eq(ClubFields.instituteName.name, instituteName);
    }
    if (clubName != null) {
      selectorBuilder.eq(ClubFields.name.name, clubName);
    }
    if (clubName == null && instituteName == null && id == null) {
      throw ArgumentError("id or instituteName or clubName must be provided");
    }

    if (forceGet) {
      await LocalDatabase.deleteKey(
          LocalCollections.club, LocalDocuments.clubs);
    } else {
      Map? res =
          await LocalDatabase.get(LocalCollections.club, LocalDocuments.clubs);
      if (res != null) {
        for (dynamic model in res.values) {
          model = Formatter.convertMapToMapStringDynamic(model);
          if (id != null && model["_id"] == id && !_isMinified(model)) {
            filteredClubs.add(ClubModel.fromJson(model));
            break;
          } else if (instituteName != null &&
              model[ClubFields.instituteName.name] == instituteName &&
              !_isMinified(model)) {
            filteredClubs.add(ClubModel.fromJson(model));
          } else if (clubName != null &&
              model[ClubFields.name.name] == clubName &&
              !_isMinified(model)) {
            filteredClubs.add(ClubModel.fromJson(model));
          }
        }
        yield filteredClubs;
      }
    }

    DbCollection collection = Database.instance.collection(_collectionName);

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();
    filteredClubs = res.map((model) => ClubModel.fromJson(model)).toList();
    for (int i = 0; i < filteredClubs.length; i++) {
      filteredClubs[i] = await _save(filteredClubs[i]);
    }
    yield filteredClubs;
  }

  /// For a given id returns only the name
  static Stream<String?> getName(String id) async* {
    Map? res =
        await LocalDatabase.get(LocalCollections.club, LocalDocuments.clubs);
    if (res != null) {
      res = Formatter.convertMapToMapStringDynamic(res)!;
      if (res.containsKey(id)) {
        yield res[id][ClubFields.name.name] as String?;
      }
    }
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq("_id", ObjectId.parse(id));
    selectorBuilder.fields([
      ClubFields.name.name,
      ClubFields.instituteName.name,
    ]);

    res = await collection.findOne(selectorBuilder);
    if (res != null) {
      ClubModel minified = await _save(ClubModel.minifiedFromJson(
        Formatter.convertMapToMapStringDynamic(res)!,
      ));
      yield minified.name;
    }
    yield null;
  }

  static Future<void> delete(String id) async {
    throw UnimplementedError();
  }

  /// In minified only the club id, name and institute name is returned
  /// Recommended to use minified
  static Stream<List<ClubModel>> listAllClubs(
      {List<String> instituteName = const [], bool minified = true}) async* {
    List<ClubModel> filteredClubs = [];
    Map? res =
        await LocalDatabase.get(LocalCollections.club, LocalDocuments.clubs);
    if (res != null) {
      res = Formatter.convertMapToMapStringDynamic(res)!;
      if (minified == true) {
        for (dynamic model in res.values) {
          ClubModel clubModel = ClubModel.minifiedFromJson(model);
          if (instituteName.isEmpty ||
              instituteName.contains(clubModel.instituteName)) {
            filteredClubs.add(clubModel);
          }
        }
      } else {
        for (dynamic model in res.values) {
          if (!_isMinified(model)) {
            ClubModel clubModel = ClubModel.minifiedFromJson(model);
            if (instituteName.isEmpty ||
                instituteName.contains(clubModel.instituteName)) {
              filteredClubs.add(clubModel);
            }
          }
        }
      }
      yield filteredClubs;
    }

    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    if (minified) {
      selectorBuilder.fields([
        "_id",
        ClubFields.name.name,
        ClubFields.instituteName.name,
      ]);
    }

    if (instituteName.isNotEmpty) {
      selectorBuilder.all(ClubFields.instituteName.name, instituteName);
    }

    List<Map<String, dynamic>> listResponse =
        await collection.find(selectorBuilder).toList();
    filteredClubs = [];
    for (Map<String, dynamic> val in listResponse) {
      ClubModel clubModel = ClubModel.minifiedFromJson(val);
      clubModel = await _save(clubModel);
      filteredClubs.add(clubModel);
    }
    yield filteredClubs;
  }
}
