import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/pages/homepage_base/event_widget.dart';

///list of events of class EventModel
List<EventModel> eventListUnmodified = [
  /*EventModel(
    posterURL: posterURL,
    title: title,
    shortDescription: shortDescription,
    startDate: startDate,
    endDate: endDate,
    registrationLink: registrationLink,
    venue: venue,
    contacts: contacts,
    clubID: clubID,
  )*/
];

List<EventDisplayStyle> eventList = eventListUnmodified
    .map((EventModel itemData) => EventDisplayStyle(eventDetails: itemData))
    .toList();
