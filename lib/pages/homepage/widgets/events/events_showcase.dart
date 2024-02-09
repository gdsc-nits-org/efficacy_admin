import 'dart:collection';
import 'dart:math';

import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/create_update_event/create_update_event.dart';
import 'package:efficacy_admin/pages/event_details_view/event_viewer.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/_get_club_id.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_card.dart';
import 'package:flutter/material.dart';

class EventsShowcasePage extends StatefulWidget {
  final EventStatus eventStatus;
  final GlobalKey? createEventKey;
  const EventsShowcasePage({
    super.key,
    this.createEventKey,
    required this.eventStatus,
  });

  @override
  State<EventsShowcasePage> createState() => _EventsShowcasePageState();
}

class _EventsShowcasePageState extends State<EventsShowcasePage> {
  late Stream<EventPaginationResponse> eventStream;
  EventStatus? currentEventStatus;
  int skip = 0;

  final ScrollController _controller = ScrollController();
  SplayTreeSet<EventModel> allEvents =
  SplayTreeSet<EventModel>(sortCompareEvents);
  SplayTreeSet<EventModel> upcomingEvents =
  SplayTreeSet<EventModel>(sortCompareEvents);
  SplayTreeSet<EventModel> ongoingEvents =
  SplayTreeSet<EventModel>(sortCompareEvents);
  SplayTreeSet<EventModel> completedEvents =
  SplayTreeSet<EventModel>(sortCompareEvents);

  int itemCount = 0;

  static int sortCompareEvents(EventModel a, EventModel b) {
    return a.startDate == b.startDate
        ? a.endDate.compareTo(b.endDate)
        : a.startDate.compareTo(b.startDate);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          if (skip != -1) {
            eventStream = EventController.getAllEvents(
              eventStatus: currentEventStatus,
              clubIDs: getClubIDs(UserController.clubs),
              skip: skip,
            );
          }
        });
      }
    });
  }

  void addNewEvent(EventModel newEvent) {
    allEvents.add(newEvent);
    switch (newEvent.type) {
      case EventStatus.Upcoming:
        upcomingEvents.add(newEvent);
        break;
      case EventStatus.Ongoing:
        ongoingEvents.add(newEvent);
        break;
      case EventStatus.Completed:
        completedEvents.add(newEvent);
        break;
    }
  }

  void updateEvent(EventModel oldEvent, EventModel newEvent) {
    allEvents.remove(oldEvent);
    allEvents.add(newEvent);

    switch (oldEvent.type) {
      case EventStatus.Upcoming:
        upcomingEvents.remove(oldEvent);
        break;
      case EventStatus.Ongoing:
        ongoingEvents.remove(oldEvent);
        break;
      case EventStatus.Completed:
        completedEvents.remove(oldEvent);
        break;
    }
    switch (newEvent.type) {
      case EventStatus.Upcoming:
        upcomingEvents.add(newEvent);
        break;
      case EventStatus.Ongoing:
        ongoingEvents.add(newEvent);
        break;
      case EventStatus.Completed:
        completedEvents.add(newEvent);
        break;
    }
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

  Future<void> refresh() async {
    skip = 0;
    allEvents.clear();
    upcomingEvents.clear();
    ongoingEvents.clear();
    completedEvents.clear();
    EventPaginationResponse response = await EventController.getAllEvents(
      clubIDs: getClubIDs(UserController.clubs),
      skip: skip,
      forceGet: true,
      eventStatus: currentEventStatus,
    ).first;
    setState(() {
      skip = response.skip;
      categoriseNewEvents(response.events);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    if (widget.eventStatus != currentEventStatus) {
      currentEventStatus = widget.eventStatus;

      eventStream = EventController.getAllEvents(
        eventStatus: currentEventStatus,
        clubIDs: getClubIDs(UserController.clubs),
      );
    }
    return Scaffold(
      floatingActionButton: UserController.clubWithModifyEventPermission
          .isNotEmpty // If there is no club where the user can edit/create event don't show the option
          ? FloatingActionButton(
        key: widget.createEventKey,
        onPressed: () async {
          final eventUpdated = await Navigator.pushNamed(
              context, CreateUpdateEvent.routeName);
          if (eventUpdated != null && eventUpdated is EventModel) {
            addNewEvent(eventUpdated);
          }
        },
        child: const Icon(Icons.add),
      )
          : null,
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: eventStream,
                builder:
                    (context, AsyncSnapshot<EventPaginationResponse> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child:
                      Text("Some Error occurred. Please restart the app."),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: max(1, itemCount),
                      itemBuilder: (context, index) {
                        if (itemCount == 0) {
                          return SizedBox(
                            width: screen.width,
                            height: screen.height * .7,
                            child: const Center(child: Text("No event found")),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: InkWell(
                            onTap: () async {
                              final eventUpdated = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EventsViewer(currentEvent: events[index]),
                                ),
                              );
                              if (eventUpdated != null &&
                                  eventUpdated is EventModel) {
                                updateEvent(events[index], eventUpdated);
                              }
                            },
                            child: EventCard(event: events[index]),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}