import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  const EventModel._();
  const factory EventModel({
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
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, Object?> json) =>
      _$EventModelFromJson(json);

  String get type {
    DateTime currentTime = DateTime.now();
    if (endDate.isBefore(currentTime)) {
      return "Completed";
    } else if (startDate.isAfter(currentTime)) {
      return "Upcoming";
    } else {
      return "Ongoing";
    }
  }
}
