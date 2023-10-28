import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class InvitationController {
  static const String _collectionName = "invitations";
  const InvitationController._();

  static Future<InvitationModel> _save(InvitationModel invitation) async {
    Map? invitations = await LocalDatabase.get(
      LocalCollections.invitations,
      LocalDocuments.invitations,
    );
    invitations ??= {};
    invitation = invitation.copyWith(lastLocalUpdate: DateTime.now());
    invitations[invitation.id] = invitation.toJson();
    await LocalDatabase.set(
      LocalCollections.invitations,
      LocalDocuments.invitations,
      invitations,
    );
    return invitation;
  }

  static Future<InvitationModel?> create(InvitationModel invitation) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    await Database.instance.createCollection(
      _collectionName,
      rawOptions: {
        "expireAfterSeconds": 60 * 60 * 24 * 7, // 7 Days
      },
    );
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(
      InvitationFields.clubPositionID.name,
      invitation.clubPositionID,
    );
    selectorBuilder.eq(
      InvitationFields.recipientID.name,
      invitation.recipientID,
    );

    if (await collection.findOne(selectorBuilder) != null) {
      throw Exception("Recipient is already invited for the provided position");
    }
    await collection.insertOne(invitation.toJson());
    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res == null) return null;
    invitation = InvitationModel.fromJson(res);
    invitation = await _save(invitation);
    return invitation;
  }

  static Stream<List<InvitationModel>> get({
    required String senderID,
    bool forceGet = false,
  }) async* {
    List<InvitationModel> invitations = [];
    if (forceGet) {
      await LocalDatabase.deleteKey(
        LocalCollections.invitations,
        LocalDocuments.invitations,
      );
    } else {
      Map? res = await LocalDatabase.get(
        LocalCollections.invitations,
        LocalDocuments.invitations,
      );
      if (res != null) {
        for (dynamic model in res.values) {
          model = Formatter.convertMapToMapStringDynamic(model);
          if (model["_id"] == senderID) {
            invitations.add(InvitationModel.fromJson(model));
          }
        }
        yield invitations;
      }
    }
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq("_id", senderID);

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();
    invitations = res.map((model) => InvitationModel.fromJson(model)).toList();
    for (int i = 0; i < invitations.length; i++) {
      invitations[i] = await _save(invitations[i]);
    }
    yield invitations;
  }

  static Future<InvitationModel?> update(InvitationModel invitation) async {
    throw UnimplementedError();
  }

  static Future<void> delete(String invitationID) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selector = SelectorBuilder();
    selector.eq("_id", invitationID);
    if (await collection.findOne(selector) == null) {
      throw Exception(
          "Could not find invitation. Invitation might have expired");
    }

    await collection.deleteOne(selector);
    await _deleteLocal(invitationID);
  }

  static Future<void> _deleteLocal(String id) async {
    Map? invitations = await LocalDatabase.get(
      LocalCollections.invitations,
      LocalDocuments.invitations,
    );
    if (invitations == null || !invitations.containsKey(id)) return;
    invitations.remove(id);
    await LocalDatabase.set(
      LocalCollections.invitations,
      LocalDocuments.invitations,
      invitations,
    );
  }
}
