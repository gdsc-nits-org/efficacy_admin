
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/controllers/services/event/event_controller.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/_get_club_id.dart';
import 'package:efficacy_admin/pages/homepage/widgets/events/event_card.dart';
import 'package:flutter/material.dart';

class EventsShowcasePage extends StatefulWidget {
  final int currentTabIndex;
  const EventsShowcasePage({
    super.key,
    required this.currentTabIndex,
  });

  @override
  State<EventsShowcasePage> createState() => _EventsShowcasePageState();
}

class _EventsShowcasePageState extends State<EventsShowcasePage> {
  Stream<EventPaginationResponse> event = EventController.getAllEvents(clubIDs: getClubIDs(UserController.clubs));
  int skip = 0;

  final ScrollController _controller = ScrollController();
  List<EventModel> events = [];
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          event = EventController.getAllEvents(skip: skip);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            "${Status.values[widget.currentTabIndex].toString().split('.').last} Events",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              color: const Color.fromARGB(253, 82, 81, 81),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: event,
            builder:
                (context, AsyncSnapshot<EventPaginationResponse> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data != null) {
                  if (skip != snapshot.data!.skip) {
                    skip = snapshot.data!.skip;
                    events.addAll(snapshot.data!.events);
                  }
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
                          item: snapshot.data != null ? events[index] : null),
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
