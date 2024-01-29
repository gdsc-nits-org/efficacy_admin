import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/controllers/services/club/club_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/pages/create_update_event/create_update_event.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/contributors.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/event_registration_button.dart';
import 'package:efficacy_admin/pages/event_details_view/widgets/stats_info.dart';
import 'package:efficacy_admin/utils/custom_network_image.dart';
import 'package:efficacy_admin/utils/share_handler.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

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
  void toggleLike() {
    List<String> liked = List.from(event.liked);

    if (UserController.currentUser != null) {
      // For faster response as soon as the user presses the like button
      // it is reflected on the frontend side.
      //
      // Once the backend completes its work it then updates the state
      // confirming the final state
      String email = UserController.currentUser!.email;
      bool couldRemove = liked.remove(email);
      if (!couldRemove) {
        liked.add(email);
      }
      EventController.toggleLike(userEmail: email, event: event)
          .then((updatedEvent) async {
        // The delay ensures that both the event update (local and with backend)
        // never happen simultaneously else it would cause 2 time screen update
        // which might crash the widget
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          event = updatedEvent;
        });
      });
      setState(() {
        event = event.copyWith(liked: liked);
      });
    } else {
      showErrorSnackBar(context, "Please log in again");
    }
  }

  late EventModel event;
  @override
  void initState() {
    super.initState();
    event = widget.currentEvent;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: UserController.clubWithModifyEventPermission
                  .indexWhere((club) => club.id == event.clubID) !=
              -1
          ? FloatingActionButton(
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
                      List<ClubModel> clubs = await ClubController.get(
                              id: widget.currentEvent.clubID)
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
            )
          : null,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.currentEvent.posterURL.isEmpty ||
                          widget.currentEvent.posterURL == "null"
                      ? Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Image.asset(
                            Assets.mediaImgPath,
                            fit: BoxFit.cover,
                            height: screenHeight * 0.4,
                          ),
                        )
                      : CustomNetworkImage(
                          url: widget.currentEvent.posterURL,
                          height: screenHeight * 0.4,
                          errorWidget: (BuildContext context, _, __) {
                            return Image.asset(
                              Assets.mediaImgPath,
                              height: screenHeight * 0.4,
                            );
                          },
                        ),
                  const Gap(50),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Where and when",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontSize: 20, color: dark),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: dark,
                            ),
                            Text(
                              widget.currentEvent.venue.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: dark),
                            ),
                          ].separate(10),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: dark,
                            ),
                            Text(
                              "${DateFormat('d MMM yyyy').format(widget.currentEvent.startDate)} - ${DateFormat('d MMM yyyy').format(widget.currentEvent.endDate)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: dark),
                            )
                          ].separate(10),
                        ),
                        const Gap(3),
                        // EventStats(currentEvent: widget.currentEvent),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => toggleLike(),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: dark, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      event.liked.contains(
                                              UserController.currentUser!.email)
                                          ? const Icon(
                                              Icons.thumb_up,
                                              color: dark,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.thumb_up_outlined,
                                              color: dark,
                                              size: 20,
                                            ),
                                      const StatsInfo(
                                        message: "Like", //"$likeCount",
                                      ),
                                    ].separate(10),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  await showLoadingOverlay(
                                      context: context,
                                      asyncTask: () async {
                                        await ShareHandler.shareEvent(
                                            widget.currentEvent);
                                      });
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: dark, width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.share,
                                        color: dark,
                                        size: 20,
                                      ),
                                      const StatsInfo(message: "Share")
                                    ].separate(10),
                                  ),
                                ),
                              ),
                            )
                          ].separate(40),
                        ),
                        const Gap(3),
                        const Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        const Gap(3),
                        const Text(
                          "About the event",
                          style: TextStyle(
                              color: dark,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const Gap(3),
                        widget.currentEvent.longDescription != null
                            ? Text(
                                widget.currentEvent.longDescription.toString())
                            : Text(widget.currentEvent.shortDescription),
                        const Gap(3),
                        Container(
                          width: screenWidth,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.currentEvent.registrationLink !=
                                      null &&
                                  widget.currentEvent.registrationLink!
                                      .isNotEmpty)
                                Expanded(
                                  child: EventRegistrationButton(
                                      onTap: () {
                                        showLoadingOverlay(
                                            context: context,
                                            asyncTask: () async {
                                              await launchUrlString(widget
                                                  .currentEvent
                                                  .registrationLink!);
                                            });
                                      },
                                      icon: Image.asset(
                                        Assets.googleLogoImagePath,
                                      ),
                                      message: "Google Form"),
                                ),
                              if (widget.currentEvent.facebookPostURL != null &&
                                  widget
                                      .currentEvent.facebookPostURL!.isNotEmpty)
                                Expanded(
                                  child: EventRegistrationButton(
                                    onTap: () async {
                                      await showLoadingOverlay(
                                          context: context,
                                          asyncTask: () async {
                                            launchUrlString(widget
                                                .currentEvent.facebookPostURL!);
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.facebook,
                                      color: dark,
                                    ),
                                    message: "Facebook",
                                  ),
                                ),
                            ].separate(8),
                          ),
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        const Gap(3),
                        if (widget.currentEvent.contacts.isNotEmpty)
                          Contributors(
                              contacts: widget.currentEvent.contacts,
                              role: "Moderators"),
                        const SizedBox(height: 40),
                      ].separate(10),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.32,
              left: screenWidth * .05,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ]),
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * .6,
                          ),
                          child: Text(
                            widget.currentEvent.title,
                            style: const TextStyle(
                              color: dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: null,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * .6,
                          ),
                          child: StreamBuilder(
                              stream: ClubController.get(
                                  id: widget.currentEvent.clubID),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                List<ClubModel> club = [];
                                if (snapshot.hasData) {
                                  club = snapshot.data ?? [];
                                }
                                if (club.isNotEmpty) {
                                  return Text(
                                    club.first.name,
                                    style: const TextStyle(color: dark),
                                    maxLines: null,
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.grey,
                                size: 16,
                              ),
                              Text(
                                "${event.liked.length} Likes",
                                style: const TextStyle(fontSize: 13),
                              ),
                            ].separate(5),
                          ),
                        )
                      ].separate(5),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: dark,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('MMM')
                                .format(widget.currentEvent.startDate),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              DateFormat('d')
                                  .format(widget.currentEvent.startDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: IconButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: dark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
