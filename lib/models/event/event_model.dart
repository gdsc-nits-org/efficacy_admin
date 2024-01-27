import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

enum EventStatus { Upcoming, Ongoing, Completed }

@Freezed(fromJson: true, toJson: true)
class EventModel with _$EventModel {
  const EventModel._();
  const factory EventModel({
    @JsonKey(name: "_id") String? id,
    required String posterURL,
    required String posterPublicID,
    required String title,
    required String shortDescription,
    String? longDescription,
    required DateTime startDate,
    required DateTime endDate,
    required String registrationLink,
    String? facebookPostURL,
    required String venue,

    /// Email of the responsible members for the event
    required List<String> contacts,

    /// Users who liked the event
    /// Emails are stored
    @Default([]) List<String> liked,
    required String clubID,
    DateTime? lastLocalUpdate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, Object?> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    if (kDebugMode) {
      json["posterURL"] ??= "test";
      json["posterPublicID"] ??= "test";
    }
    return _$EventModelFromJson(json);
  }

  EventStatus get type {
    DateTime currentTime = DateTime.now();
    if (endDate.isBefore(currentTime)) {
      return EventStatus.Completed;
    } else if (startDate.isAfter(currentTime)) {
      return EventStatus.Upcoming;
    } else {
      return EventStatus.Ongoing;
    }
  }

  @override
  bool operator ==(dynamic other) {
    return id != null && other.id != null
        ? (id == other.id)
        : identical(this, other) ||
            (other.runtimeType == runtimeType &&
                other is _$EventModelImpl &&
                (identical(other.id, id) || other.id == id) &&
                (identical(other.posterURL, posterURL) ||
                    other.posterURL == posterURL) &&
                (identical(other.title, title) || other.title == title) &&
                (identical(other.shortDescription, shortDescription) ||
                    other.shortDescription == shortDescription) &&
                (identical(other.longDescription, longDescription) ||
                    other.longDescription == longDescription) &&
                (identical(other.startDate, startDate) ||
                    other.startDate == startDate) &&
                (identical(other.endDate, endDate) ||
                    other.endDate == endDate) &&
                (identical(other.registrationLink, registrationLink) ||
                    other.registrationLink == registrationLink) &&
                (identical(other.facebookPostURL, facebookPostURL) ||
                    other.facebookPostURL == facebookPostURL) &&
                (identical(other.venue, venue) || other.venue == venue) &&
                const DeepCollectionEquality()
                    .equals(other.contacts, contacts) &&
                const DeepCollectionEquality().equals(other.liked, liked) &&
                (identical(other.clubID, clubID) || other.clubID == clubID) &&
                (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                    other.lastLocalUpdate == lastLocalUpdate) &&
                (identical(other.createdAt, createdAt) ||
                    other.createdAt == createdAt) &&
                (identical(other.updatedAt, updatedAt) ||
                    other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => id != null
      ? Object.hash(runtimeType, id)
      : Object.hash(
          runtimeType,
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
          const DeepCollectionEquality().hash(contacts),
          const DeepCollectionEquality().hash(liked),
          clubID,
          lastLocalUpdate,
          createdAt,
          updatedAt);
}

enum EventFields {
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
  lastLocalUpdate,
  createdAt,
  updatedAt,
}
