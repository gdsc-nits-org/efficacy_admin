part of '../invitation_controller.dart';

Future<bool> _anyPendingInvitationImpl() async {
  if (UserController.currentUser == null) {
    throw Exception("Please Login");
  }
  DbCollection collection =
      Database.instance.collection(InvitationController._collectionName);
  SelectorBuilder selector = SelectorBuilder();
  selector.eq(
    InvitationFields.recipientID.name,
    UserController.currentUser!.id,
  );

  Map<String, dynamic>? res = await collection.findOne(selector);
  if (res == null) return false;

  await InvitationController._save(InvitationModel.fromJson(res));
  return true;
}
