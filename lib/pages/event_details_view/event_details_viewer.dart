import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/contributors.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/event_registration_button.dart';
import 'widgets/event_stats.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetailsViewer extends StatefulWidget {
  static const String routeName = "/eventDetails";

  const EventDetailsViewer({Key? key, required this.currentEvent})
      : super(key: key);
  final EventModel currentEvent;

  @override
  State<EventDetailsViewer> createState() => _EventDetailsViewerState();
}

class _EventDetailsViewerState extends State<EventDetailsViewer> {
  late EventModel event;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _refreshData() async {
    List<EventModel> updatedEvent = await EventController.get(
      eventID: widget.currentEvent.id,
      forceGet: true,
    ).first;
    if (updatedEvent.isNotEmpty) {
      setState(() {
        event = updatedEvent.first;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    event = widget.currentEvent;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w800,
                      fontSize: screenWidth * 0.094,
                    ),
                  ),
                  Text(event.shortDescription),
                ].separate(15),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    EventRegistrationButton(
                      onTap: () {},
                      icon: Image.asset(
                        Assets.googleLogoImagePath,
                      ),
                      message: "Google Form",
                    ),
                    EventRegistrationButton(
                      onTap: () {},
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        color: dark,
                      ),
                      message: "Facebook",
                    ),
                  ].separate(8),
                ),
              ),
              const Text(
                "Event Stats",
                style: TextStyle(
                  color: dark,
                  fontSize: 20,
                ),
              ),
              EventStats(currentEventDate: event.startDate),
              const Contributors(role: "Added By"),
              const Contributors(role: "Moderators"),
            ].separate(20),
          ),
        ),
      ),
    );
  }
}
