import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitaion_model.g.dart';
part 'invitaion_model.freezed.dart';

@Freezed(fromJson: true, toJson: true)
class InvitationModel with _$InvitationModel {
  const InvitationModel._();
  const factory InvitationModel({
    @JsonKey(name: "_id") String? id,
    required String clubPositionID,
    required String senderID,
    required String recipientID,
    // Default to creation time + a fixed time
    required DateTime expiry,
    DateTime? lastLocalUpdate,
  }) = _InvitationModel;

  factory InvitationModel.fromJson(Map<String, dynamic> json) =>
      _$InvitationModelFromJson(json);
}

enum InvitationFields {
  id,
  clubPositionID,
  senderID,
  recipientID,
  expiry,
  lastLocalUpdate,
}
