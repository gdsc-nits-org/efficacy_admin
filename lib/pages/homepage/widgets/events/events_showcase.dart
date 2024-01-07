import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/_get_club_id.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_card.dart';
import 'package:flutter/material.dart';

class EventsShowcasePage extends StatefulWidget {
  final EventStatus eventStatus;
  const EventsShowcasePage({
    super.key,
    required this.eventStatus,
  });

  @override
  State<EventsShowcasePage> createState() => _EventsShowcasePageState();
}

class _EventsShowcasePageState extends State<EventsShowcasePage> {
  Stream<EventPaginationResponse> event = EventController.getAllEvents(
    clubIDs: getClubIDs(UserController.clubs),
  );
  int skip = 0;

  final ScrollController _controller = ScrollController();
  Set<EventModel> allEvents = {};
  Set<EventModel> upcomingEvents = {};
  Set<EventModel> ongoingEvents = {};
  Set<EventModel> completedEvents = {};

  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          event = EventController.getAllEvents(
            clubIDs: getClubIDs(UserController.clubs),
            skip: skip,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void categoriseNewEvents(List<EventModel> events) {
    allEvents.addAll(events);
    for (EventModel event in events) {
      switch (event.type) {
        case EventStatus.Upcoming:
          upcomingEvents.add(event);
          break;
        case EventStatus.Ongoing:
          ongoingEvents.add(event);
          break;
        case EventStatus.Completed:
          completedEvents.add(event);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder(
            stream: event,
            builder:
                (context, AsyncSnapshot<EventPaginationResponse> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some Error occurred. Please restart the app."),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data != null) {
                  skip = snapshot.data!.skip;
                  categoriseNewEvents(snapshot.data!.events);
                }
                List<EventModel> events;
                switch (widget.eventStatus) {
                  case EventStatus.Upcoming:
                    events = upcomingEvents.toList();
                    break;
                  case EventStatus.Ongoing:
                    events = ongoingEvents.toList();
                    break;
                  case EventStatus.Completed:
                    events = completedEvents.toList();
                    break;
                }
                itemCount = events.length;
                return ListView.builder(
                  controller: _controller,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: EventCard(
                        item: snapshot.data != null ? events[index] : null,
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
