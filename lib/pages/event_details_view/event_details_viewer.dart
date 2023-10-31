import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/contributors.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/event_registration_button.dart';
import 'widgets/event_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetailsViewer extends StatelessWidget {
  static const String routeName = "/eventDetails";
  const EventDetailsViewer({super.key, required this.currentEvent});
  final EventModel currentEvent;

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
                Text(
                  currentEvent.title,
                  style: TextStyle(
                    color: dark,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.094,
                  ),
                ),
                Text(currentEvent.shortDescription),
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
            EventStats(
              currentEventDate: currentEvent.startDate,
            ),
            const Contributors(role: "Added By"),
            const Contributors(role: "Moderators"),
          ].separate(20),
        ),
      ),
    );
  }
}
