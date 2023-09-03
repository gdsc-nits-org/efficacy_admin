import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
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
  }) = _Event;

  factory Event.fromJson(Map<String, Object?> json) => _$EventFromJson(json);
}
