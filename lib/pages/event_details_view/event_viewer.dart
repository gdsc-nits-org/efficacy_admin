import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/club/club_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/pages/create_update_event/create_update_event.dart';
import 'package:efficacy_admin/pages/create_update_event/create_update_event.dart';
import 'package:efficacy_admin/utils/custom_network_image.dart';
import 'event_details.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventsViewer extends StatefulWidget {
  static const String routeName = "/eventFullScreen";
  final EventModel currentEvent;
  const EventsViewer({
    super.key,
    required this.currentEvent,
  });

  @override
  State<EventsViewer> createState() => _EventsViewerState();
}

class _EventsViewerState extends State<EventsViewer> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
            panel: EventDetails(currentEvent: widget.currentEvent),
            body: Column(
              children: [
                widget.currentEvent.posterURL.isEmpty
                    ? Image.asset(
                        Assets.mediaImgPath,
                        fit: BoxFit.cover,
                        height: screenHeight * 0.4,
                      )
                    : CustomNetworkImage(
                        url: widget.currentEvent.posterURL,
                        height: screenHeight * 0.4,
                        errorWidget: (BuildContext context, _, __) {
                          return Image.asset(
                            Assets.mediaImgPath,
                            fit: BoxFit.cover,
                            height: screenHeight * 0.4,
                          );
                        },
                      ),
                // Image.network(
                //   widget.currentEvent.posterURL,
                //   fit: BoxFit.cover,
                //   height: screenHeight * 0.4,
                // ),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              UserModel? moderator;
              ClubModel? club;
              showLoadingOverlay(
                  context: context,
                  asyncTask: () async {
                    if (widget.currentEvent.contacts.isNotEmpty) {
                      List<UserModel> moderators = await UserController.get(
                              email: widget.currentEvent.contacts.first)
                          .first;
                      if (moderators.isNotEmpty) {
                        moderator = moderators.first;
                      }
                    }
                    List<ClubModel> clubs =
                        await ClubController.get(id: widget.currentEvent.clubID)
                            .first;
                    if (clubs.isNotEmpty) {
                      club = clubs.first;
                    }
                  },
                  onCompleted: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CreateUpdateEvent(
                          event: widget.currentEvent,
                          club: club,
                          moderator: moderator,
                        ),
                      ),
                    ).then(
                      (eventUpdated) => Navigator.pop(context, eventUpdated),
                    );
                  });
            },
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
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.close,
                  size: screenHeight * 0.035,
                  color: dark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
