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
  final ValueNotifier<int> currentEventFilterTypeIndex;
  final GlobalKey? createEventKey;
  const EventsShowcasePage({
    super.key,
    this.createEventKey,
    required this.currentEventFilterTypeIndex,
  });

  @override
  State<EventsShowcasePage> createState() => _EventsShowcasePageState();
}

class _EventsShowcasePageState extends State<EventsShowcasePage> {
  late Stream<EventPaginationResponse> eventStream;
  int skip = 0;

  final ScrollController _controller = ScrollController();
  SplayTreeSet<EventModel> allEvents =
      SplayTreeSet<EventModel>(sortCompareEvents);

  int itemCount = 0;
  EventStatus? currentEventStatus;

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
  }

  void updateEvent(EventModel oldEvent, EventModel newEvent) {
    allEvents.remove(oldEvent);
    allEvents.add(newEvent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> refresh() async {
    allEvents.clear();
    EventPaginationResponse response = await EventController.getAllEvents(
      eventStatus: currentEventStatus,
      clubIDs: getClubIDs(UserController.clubs),
      skip: skip,
      forceGet: true,
    ).first;
    setState(() {
      skip = 0;
      eventStream = EventController.getAllEvents(
        clubIDs: getClubIDs(UserController.clubs),
        eventStatus: currentEventStatus,
        skip: skip,
      );
      skip = response.skip;
      allEvents.addAll(response.events);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: ValueListenableBuilder(
            valueListenable: widget.currentEventFilterTypeIndex,
            builder: (context, int currentEventFilterTypeIndex, _) {
              Size screen = MediaQuery.of(context).size;
              EventStatus status =
                  EventStatus.values[currentEventFilterTypeIndex];
              allEvents.clear();
              if (status != currentEventStatus) {
                currentEventStatus = status;
                skip = 0;
                eventStream = EventController.getAllEvents(
                  skip: skip,
                  clubIDs: getClubIDs(UserController.clubs),
                  eventStatus: currentEventStatus,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: eventStream,
                      builder: (context,
                          AsyncSnapshot<EventPaginationResponse> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                                "Some Error occurred. Please restart the app."),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (snapshot.data != null) {
                            skip = snapshot.data!.skip;
                            allEvents.addAll(snapshot.data!.events);
                          }
                          List<EventModel> events = allEvents.toList();
                          itemCount = events.length;
                          return ListView.builder(
                            controller: _controller,
                            itemCount: max(1, itemCount),
                            itemBuilder: (context, index) {
                              if (itemCount == 0) {
                                return SizedBox(
                                  width: screen.width,
                                  height: screen.height * .7,
                                  child: const Center(
                                      child: Text("No event found")),
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
                                            EventsViewer(
                                                currentEvent: events[index]),
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
              );
            }),
      ),
    );
  }
}
