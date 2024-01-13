import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/contributors.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/event_registration_button.dart';
import 'widgets/event_stats.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = "/eventDetails";
  final EventModel currentEvent;

  const EventDetails({
    Key? key,
    required this.currentEvent,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late EventModel event;

  @override
  void initState() {
    super.initState();
    event = widget.currentEvent;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    event.title,
                    style: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w800,
                      fontSize: screenWidth * 0.07,
                    ),
                    textAlign: TextAlign.left,
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
            Contributors(role: "Added By", contacts: [],),
            Contributors(role: "Moderators", contacts: event.contacts,),
          ].separate(20),
        ),
      ),
    );
  }
}
