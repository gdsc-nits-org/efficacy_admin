part of '../invitation_controller.dart';

Stream<List<InvitationModel>> _getImpl({
  String? senderID,
  String? recipientID,
  String? invitationID,
  bool forceGet = false,
}) async* {
  List<InvitationModel> invitations = [];
  if (senderID == null && invitationID == null && recipientID == null) {
    throw ArgumentError(
        "Either Invitation or Sender ID or RecipientID is required");
  }
  invitations = await _fetchLocal(
    senderID: senderID,
    recipientID: recipientID,
    invitationID: invitationID,
    forceGet: forceGet,
  );
  if (invitations.isNotEmpty) yield invitations;

  invitations = await _fetchFromBackend(
    senderID: senderID,
    recipientID: recipientID,
    invitationID: invitationID,
    forceGet: forceGet,
  );
  yield invitations;
}

Future<List<InvitationModel>> _fetchLocal({
  String? senderID,
  String? recipientID,
  String? invitationID,
  bool forceGet = false,
}) async {
  List<InvitationModel> invitations = [];
  if (forceGet) {
    await LocalDatabase.deleteKey(LocalDocuments.invitations.name);
  } else {
    List<String> data = LocalDatabase.get(LocalDocuments.invitations.name);
    Map res = data.isEmpty ? {} : jsonDecode(data[0]);
    List<String> toDel = [];
    for (dynamic model in res.values) {
      model = Formatter.convertMapToMapStringDynamic(model);
      InvitationModel invitation = InvitationModel.fromJson(model);
      if (invitation.expiry!.millisecondsSinceEpoch <=
          DateTime.now().millisecondsSinceEpoch) {
        toDel.add(invitation.id!);
      } else if (recipientID != null && invitation.recipientID == recipientID) {
        invitations.add(invitation);
      } else if (invitationID != null && invitation.id == invitationID) {
        invitations.add(invitation);
        break;
      } else if (senderID != null && invitation.senderID == senderID) {
        invitations.add(invitation);
      }
    }
    for (String id in toDel) {
      await InvitationController._deleteLocal(id);
    }
  }
  return invitations;
}

Future<List<InvitationModel>> _fetchFromBackend({
  String? senderID,
  String? recipientID,
  String? invitationID,
  bool forceGet = false,
}) async {
  List<InvitationModel> invitations = [];
  DbCollection collection =
      Database.instance.collection(InvitationController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  if (senderID != null) {
    selectorBuilder.eq(InvitationFields.senderID.name, senderID);
  } else if (invitationID != null) {
    selectorBuilder.eq("_id", ObjectId.parse(invitationID));
  } else if (recipientID != null) {
    selectorBuilder.eq(InvitationFields.recipientID.name, recipientID);
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
      filtered.add(await InvitationController._save(invitations[i]));
      // Prefetching the data to show
      List<ClubPositionModel> model = await ClubPositionController.get(
              clubPositionID: invitations.last.clubPositionID)
          .first;
      if (model.isNotEmpty) {
        await ClubController.get(id: model.first.id).first;
        await UserController.get(id: filtered.last.senderID).first;
      }
    }
  }

  selectorBuilder = SelectorBuilder();
  selectorBuilder.oneFrom("_id", toDel);
  await collection.deleteMany(selectorBuilder);

  return filtered;
}
