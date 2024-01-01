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

  Map? res = await collection.findOne(selectorBuilder);
  InvitationModel? temp;
  if (res != null) {
    temp =
        InvitationModel.fromJson(Formatter.convertMapToMapStringDynamic(res)!);
  }
  if (res != null && temp?.id != invitation.id) {
    throw Exception("Recipient is already invited for the provided position");
  }
}
