import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
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

  static Future<void> _checkDuplicate(InvitationModel invitation) async {
    DbCollection collection = Database.instance.collection(_collectionName);

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
  }

  static Future<InvitationModel?> create(InvitationModel invitation) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    await _checkDuplicate(invitation);

    Duration expiryDuration = const Duration(seconds: 1);

    DateTime now = DateTime.now();
    invitation = invitation.copyWith(
      expiry: now.add(expiryDuration),
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

    await collection.insertOne(invitation.toJson());
    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res == null) return null;
    invitation = InvitationModel.fromJson(res);
    invitation = await _save(invitation);
    return invitation;
  }

  static Stream<List<InvitationModel>> get({
    String? senderID,
    String? invitationID,
    bool forceGet = false,
  }) async* {
    List<InvitationModel> invitations = [];
    if (senderID == null && invitationID == null) {
      throw ArgumentError("Either Invitation or Sender ID is required");
    }
    if (forceGet) {
      await LocalDatabase.deleteKey(
        LocalCollections.invitations,
        LocalDocuments.invitations,
      );
    } else {
      Map res = await LocalDatabase.get(
            LocalCollections.invitations,
            LocalDocuments.invitations,
          ) ??
          {};
      List<String> toDel = [];
      for (dynamic model in res.values) {
        model = Formatter.convertMapToMapStringDynamic(model);
        InvitationModel invitation = InvitationModel.fromJson(model);
        if (invitation.expiry!.millisecondsSinceEpoch <=
            DateTime.now().millisecondsSinceEpoch) {
          toDel.add(invitation.id!);
        } else if (senderID != null && invitation.senderID == senderID) {
          invitations.add(invitation);
        } else if (invitationID != null && invitation.id == invitationID) {
          invitations.add(invitation);
          break;
        }
      }
      for (String id in toDel) {
        await _deleteLocal(id);
      }
      if (invitations.isNotEmpty) yield invitations;
    }
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    if (senderID != null) {
      selectorBuilder.eq(InvitationFields.senderID.name, senderID);
    } else if (invitationID != null) {
      selectorBuilder.eq("_id", ObjectId.parse(invitationID));
    }

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();
    invitations = res.map((model) => InvitationModel.fromJson(model)).toList();
    List<ObjectId> toDel = [];
    List<InvitationModel> filtered = [];
    for (int i = 0; i < invitations.length; i++) {
      if (invitations[i].expiry!.millisecondsSinceEpoch <=
          DateTime.now().millisecondsSinceEpoch) {
        toDel.add(ObjectId.parse(invitations[i].id!));
      } else {
        filtered.add(await _save(invitations[i]));
      }
    }

    selectorBuilder = SelectorBuilder();
    selectorBuilder.all("_id", toDel);
    await collection.deleteMany(selectorBuilder);

    yield filtered;
  }

  static Future<InvitationModel?> update(InvitationModel invitation) async {
    throw UnimplementedError();
  }

  static Future<void> delete(String invitationID) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selector = SelectorBuilder();
    selector.eq("_id", ObjectId.parse(invitationID));
    if (await collection.findOne(selector) == null) {
      throw Exception(
        "Could not find invitation. Invitation might have expired",
      );
    }

    await collection.deleteOne(selector);
    await _deleteLocal(invitationID);
  }

  static Future<void> acceptInvitation(String invitationID) async {
    if (UserController.currentUser == null) {
      throw Exception("Please Login");
    }

    List<InvitationModel> invitations = await get(
      invitationID: invitationID,
      forceGet: true,
    ).first;

    if (invitations.isEmpty) {
      throw Exception("Invitation expired");
    }
    if (UserController.currentUser!.id != invitations.first.recipientID) {
      throw Exception("Permission Denied");
    }
    List<ClubPositionModel> clubPosition = await ClubPositionController.get(
      clubPositionID: invitations.first.clubPositionID,
    ).first;
    if (clubPosition.isEmpty) {
      throw Exception("Invalid Club Position");
    }
    List<ClubModel> clubs = await ClubController.get(
      id: clubPosition.first.clubID,
      forceGet: true,
    ).first;
    if (clubs.isEmpty) {
      throw Exception("Club not found");
    }
    // Accepting the invitation and updating the data
    ClubModel club = clubs.first;
    Map<String, List<String>> members = club.members;
    if (!members.containsKey(clubPosition.first.id)) {
      members[clubPosition.first.id!] = [];
    }
    members[clubPosition.first.id!]!.add(UserController.currentUser!.email);
    club = club.copyWith(members: members);
    List<String> position = UserController.currentUser!.position;
    position.add(clubPosition.first.id!);
    UserController.currentUser =
        UserController.currentUser!.copyWith(position: position);

    // Updating the data in the backend
    await Future.wait([
      ClubController.update(club),
      UserController.update(),
    ]);
  }
}
