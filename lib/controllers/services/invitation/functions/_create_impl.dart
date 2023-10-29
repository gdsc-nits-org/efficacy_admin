part of '../invitation_controller.dart';

Future<InvitationModel?> _createImpl(InvitationModel invitation) async {
  DbCollection collection =
      Database.instance.collection(InvitationController._collectionName);
  await InvitationController._checkDuplicate(invitation);

  Duration expiryDuration = const Duration(days: 7);

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
  invitation = await InvitationController._save(invitation);
  return invitation;
}
