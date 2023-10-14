import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

enum Status { Upcoming, Ongoing, Completed }

@freezed
class EventModel with _$EventModel {
  const EventModel._();
  const factory EventModel({
    @JsonKey(name: '_id') @ObjectIdSerializer() ObjectId? id,
    required String posterURL,
    required String title,
    required String shortDescription,
    String? longDescription,
    required DateTime startDate,
    required DateTime endDate,
    required String registrationLink,
    String? facebookPostURL,
    required String venue,

    /// Ids of the responsible members for the event
    required List<String> contacts,

    /// Users who liked the event
    @Default([]) List<String> liked,
    required String clubID,
    DateTime? lastLocalUpdate,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, Object?> json) =>
      _$EventModelFromJson(json);

  Status get type {
    DateTime currentTime = DateTime.now();
    if (endDate.isBefore(currentTime)) {
      return Status.Completed;
    } else if (startDate.isAfter(currentTime)) {
      return Status.Upcoming;
    } else {
      return Status.Ongoing;
    }
  }
}

enum EventFields {
  id,
  posterURL,
  title,
  shortDescription,
  longDescription,
  startDate,
  endDate,
  registrationLink,
  facebookPostURL,
  venue,
  contacts,
  liked,
  clubID,
}
