import 'package:efficacy_admin/models/invitation/invitaion_model.dart';

class InvitationController {
  static const String _collectionName = "invitations";
  const InvitationController._();

  // static Future<InvitationModel> _save(InvitationModel invitation) async {}

  static Future<InvitationModel?> create(InvitationModel invitation) async {}
  static Stream<List<InvitationModel>> get(String senderID) async* {}
  static Future<void> delete(String invitationID) async {}
}
