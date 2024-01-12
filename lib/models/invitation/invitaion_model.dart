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

  @override
  bool operator ==(dynamic other) {
    return id != null && other.id != null
        ? (id == other.id)
        : identical(this, other) ||
            (other.runtimeType == runtimeType &&
                other is _$InvitationModelImpl &&
                (identical(other.id, id) || other.id == id) &&
                (identical(other.clubPositionID, clubPositionID) ||
                    other.clubPositionID == clubPositionID) &&
                (identical(other.senderID, senderID) ||
                    other.senderID == senderID) &&
                (identical(other.recipientID, recipientID) ||
                    other.recipientID == recipientID) &&
                (identical(other.expiry, expiry) || other.expiry == expiry) &&
                (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                    other.lastLocalUpdate == lastLocalUpdate));
  }

  @override
  int get hashCode => id != null
      ? Object.hash(runtimeType, id)
      : Object.hash(runtimeType, id, clubPositionID, senderID, recipientID,
          expiry, lastLocalUpdate);
}

enum InvitationFields {
  clubPositionID,
  senderID,
  recipientID,
  expiry,
  lastLocalUpdate,
}
