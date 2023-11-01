import 'dart:convert';

import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/invitation/invitaion_model.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_save_impl.dart';
part 'functions/_delete_local_impl.dart';
part 'functions/_check_duplicate_impl.dart';
part 'functions/_create_impl.dart';
part 'functions/_get_impl.dart';
part 'functions/_delete_impl.dart';
part 'functions/_accept_invitation_impl.dart';
part 'functions/_check_permission_impl.dart';
part 'functions/_any_pending_invitation_impl.dart';

class InvitationController {
  static const String _collectionName = "invitations";
  const InvitationController._();

  static Future<InvitationModel> _save(InvitationModel invitation) async {
    return await _saveImpl(invitation);
  }

  static Future<void> _deleteLocal(String id) async {
    return await _deleteLocalImpl(id);
  }

  static Future<void> _checkPermission(String clubPositionID) async {
    return await _checkPermissionImpl(clubPositionID);
  }

  static Future<void> _checkDuplicate(InvitationModel invitation) async {
    return await _checkDuplicateImpl(invitation);
  }

  static Future<InvitationModel?> create(InvitationModel invitation) async {
    await _checkPermission(invitation.clubPositionID);
    return await _createImpl(invitation);
  }

  static Stream<List<InvitationModel>> get({
    String? senderID,
    String? invitationID,
    bool forceGet = false,
  }) {
    return _getImpl(
      senderID: senderID,
      invitationID: invitationID,
      forceGet: forceGet,
    );
  }

  static Future<InvitationModel?> update(InvitationModel invitation) async {
    throw UnimplementedError();
  }

  static Future<void> delete(InvitationModel invitation) async {
    return await _deleteImpl(invitation);
  }

  static Future<void> acceptInvitation(String invitationID) async {
    return await _acceptInvitationImpl(invitationID);
  }

  static Future<void> rejectInvitation(InvitationModel invitation) async {
    return await delete(invitation);
  }

  static Future<bool> anyPendingInvitation() async {
    return await _anyPendingInvitationImpl();
  }
}
