import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

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
    DateTime? expiry,
    DateTime? lastLocalUpdate,
  }) = _InvitationModel;

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$InvitationModelFromJson(json);
  }
}

enum InvitationFields {
  clubPositionID,
  senderID,
  recipientID,
  expiry,
  lastLocalUpdate,
}
