import 'package:efficacy_admin/config/config.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
  int likeCount = 0;
  bool isLiked = false;
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likeCount++;
      } else {
        likeCount--;
      }
    });
  }

  Widget? registrationButtons() {
    if (widget.currentEvent.facebookPostURL != null &&
        widget.currentEvent.registrationLink.isNotEmpty &&
        widget.currentEvent.facebookPostURL!.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EventRegistrationButton(
              onTap: () {},
              icon: Image.asset(
                Assets.googleLogoImagePath,
              ),
              message: "Google Form"),
          EventRegistrationButton(
            onTap: () {},
            icon: const Icon(
              FontAwesomeIcons.facebook,
              color: dark,
            ),
            message: "Facebook",
          ),
        ].separate(8),
      );
    } else if (widget.currentEvent.facebookPostURL != null &&
        widget.currentEvent.facebookPostURL!.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EventRegistrationButton(
            onTap: () {},
            icon: const Icon(
              FontAwesomeIcons.facebook,
              color: dark,
            ),
            message: "Facebook",
          ),
        ].separate(8),
      );
    } else if (widget.currentEvent.registrationLink.isNotEmpty &&
        widget.currentEvent.registrationLink != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EventRegistrationButton(
              onTap: () {},
              icon: Image.asset(
                Assets.googleLogoImagePath,
              ),
              message: "Google Form"),
        ].separate(8),
      );
    }
    return Container();
  }

  late EventModel event;
  @override
  void initState() {
    super.initState();
    event = widget.currentEvent;
    likeCount = widget.currentEvent.liked.length;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.currentEvent.posterURL.isEmpty
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Where and when",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: dark,
                              fontSize: 20),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: dark,
                            ),
                            Text(widget.currentEvent.venue.toString()),
                          ].separate(10),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: dark,
                            ),
                            Text(
                                "${DateFormat('d MMM yyyy').format(widget.currentEvent.startDate)} - ${DateFormat('d MMM yyyy').format(widget.currentEvent.endDate)}")
                          ].separate(10),
                        ),
                        const Gap(3),
                        // EventStats(currentEvent: widget.currentEvent),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => toggleLike(),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: dark, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                height: 50,
                                width: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLiked
                                        ? const Icon(
                                            Icons.thumb_up,
                                            color: dark,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.thumb_up_outlined,
                                            color: dark,
                                            size: 30,
                                          ),
                                    const StatsInfo(
                                      message: "Like", //"$likeCount",
                                    ),
                                  ].separate(10),
                                ),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: dark, width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.share,
                                      color: dark,
                                      size: 30,
                                    ),
                                    const StatsInfo(message: "Share")
                                  ].separate(10),
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
                          child: registrationButtons(),
                        ),
                        const Divider(
                          height: 10,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        const Gap(3),
                        Contributors(
                            contacts: widget.currentEvent.contacts,
                            role: "Moderators")
                      ].separate(10),
                    ),
                  ),
                ),
              ),
            ],
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
            top: screenHeight * 0.32,
            left: screenWidth * 0.05,
            bottom: screenHeight * 0.55,
            right: screenWidth * 0.05,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 244, 245, 255),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ]),
              height: 100,
              width: screenWidth * 0.9,
              child: Material(
                color: const Color.fromARGB(255, 244, 245, 255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            widget.currentEvent.title,
                            style: const TextStyle(
                              color: dark,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "$likeCount Likes",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ].separate(5),
                            ))
                      ].separate(5),
                    ),
                    Container(
                      height: 60,
                      width: 60,
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
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              DateFormat('d')
                                  .format(widget.currentEvent.startDate),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            )),
        Positioned(
          top: 20,
          left: 20,
          child: IconButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: dark)),
        ),
      ],
    );
  }
}
