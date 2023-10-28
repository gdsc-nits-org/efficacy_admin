part of '../invitation_controller.dart';

Future<void> _checkDuplicateImpl(InvitationModel invitation) async {
  DbCollection collection =
      Database.instance.collection(InvitationController._collectionName);

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
