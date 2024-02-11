part of '../invitation_controller.dart';

Future<void> _deleteImpl(InvitationModel invitation) async {
  if (UserController.currentUser == null) {
    throw Exception("Please Login");
  }
  if (invitation.senderID != UserController.currentUser!.id ||
      invitation.recipientID != UserController.currentUser!.id) {
    throw Exception("You are not authorized to delete the invitation");
  }
  DbCollection collection =
      Database.instance.collection(InvitationController._collectionName);

  SelectorBuilder selector = SelectorBuilder();
  selector.eq("_id", ObjectId.parse(invitation.id!));
  if (await collection.findOne(selector) == null) {
    throw Exception(
      "Could not find invitation. Invitation might have expired",
    );
  }

  await collection.deleteOne(selector);
  await InvitationController._deleteLocal(invitation.id!);
}
