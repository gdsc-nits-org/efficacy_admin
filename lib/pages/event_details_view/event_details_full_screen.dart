import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/event_details_view/event_details_viewer.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventFullScreen extends StatefulWidget {
  static const String routeName = "/eventFullScreen";
  const EventFullScreen({super.key, required this.currentEvent});

  final EventModel currentEvent;

  @override
  State<EventFullScreen> createState() => _EventFullScreenState();
}

class _EventFullScreenState extends State<EventFullScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final EventModel currentEvent = widget.currentEvent;
    return Stack(
      children: [
        Scaffold(
          body: SlidingUpPanel(
            header: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                ),
                Container(
                  height: 4,
                  width: screenWidth * 0.4,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 30),
            maxHeight: screenHeight,
            minHeight: screenHeight * 0.63,
            panel: EventDetailsViewer(
              currentEvent: currentEvent,
            ),
            body: Column(
              children: [
                Image.network(
                  currentEvent.posterURL,
                  fit: BoxFit.cover,
                  height: screenHeight * 0.4,
                ),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 35,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: dark,
                child: Icon(
                  Icons.close,
                  size: screenHeight * 0.035,
                  color: light,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
