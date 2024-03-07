import 'dart:math';

import 'package:efficacy_admin/controllers/services/club/club_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/pages/club/club_page.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateClubRequests extends StatefulWidget {
  const CreateClubRequests({super.key});
  static const String routeName = "/createClubRequests";
  static const double bigFontSize = 18;
  static const double smallFontSize = 14;
  static const double elevation = 5;
  static const double smallPadding = 8;
  static const double largePadding = 16;
  static const double largePaddingInvites = 10;
  static const double imageWidth = 40;
  @override
  State<CreateClubRequests> createState() => _CreateClubRequestsState();
}

class _CreateClubRequestsState extends State<CreateClubRequests> {
  List<ClubModel> requestedClubs = [];
  bool isLoading = true;
  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    List<ClubModel> updatedList = await ClubController.getRequestedClubs();
    setState(() {
      requestedClubs = updatedList;
      isLoading = false;
    });
  }

  List<Widget> buildClubs(List<ClubModel> clubs) {
    List<Widget> children = [];
    for (int index = 0; index < clubs.length; index++) {
      final club = clubs[index];
      children.add(
        ClubWidget(
          club: club,
          index: index,
          refresh: _refresh,
        ),
      );
    }
    return children;
  }

  @override
  void initState() {
    super.initState();
    ClubController.getRequestedClubs().then((clubs) {
      setState(() {
        isLoading = false;
        requestedClubs = clubs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Clubs",
      ),
      endDrawer: CustomDrawer(pageContext: context),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: isLoading || requestedClubs.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: Center(
                    child: requestedClubs.isEmpty
                        ? const Text("No requested clubs")
                        : const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                  ),
                )
              : Column(
                  children: buildClubs(requestedClubs),
                ),
        ),
      ),
    );
  }
}

class ClubWidget extends StatefulWidget {
  final ClubModel club;
  final int index;
  final Future Function() refresh;
  const ClubWidget({
    super.key,
    required this.club,
    required this.index,
    required this.refresh,
  });

  @override
  State<ClubWidget> createState() => _ClubWidgetState();
}

class _ClubWidgetState extends State<ClubWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Padding(
      padding: const EdgeInsets.all(CreateClubRequests.smallPadding),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClubPage(
                createMode: false,
                club: widget.club,
              ),
            ),
          ).then(
            (dynamic newClubDetails) {
              if (newClubDetails != null && newClubDetails is ClubModel) {
                setState(() {
                  UserController.clubs[widget.index] = newClubDetails;
                });
              }
            },
          );
        },
        child: Card(
          child: Container(
            padding: const EdgeInsets.only(
                right: CreateClubRequests.largePaddingInvites,
                left: CreateClubRequests.largePaddingInvites,
                top: CreateClubRequests.largePaddingInvites,
                bottom: CreateClubRequests.largePaddingInvites),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image(
                        image: NetworkImage(widget.club.clubLogoURL),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.people),
                        width: CreateClubRequests.imageWidth,
                        // Adjust the width as needed
                        height: CreateClubRequests.imageWidth,
                        // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width * 0.5),
                      child: Text(
                        widget.club.name,
                        maxLines: null,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Institute: ${widget.club.instituteName}',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Email: ${widget.club.email}',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Status: ${widget.club.clubStatus.name}',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(5),
                      if (isLoading)
                        const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      if (widget.club.clubStatus == ClubStatus.requested)
                        Row(
                          children: [
                            Tooltip(
                              message: "Accept",
                              child: IconButton(
                                onPressed: () async {
                                  // Handle accept invitation
                                  await showLoadingOverlay(
                                    parentContext: context,
                                    asyncTask: () async {
                                      await ClubController.acceptClub(
                                        clubID: widget.club.id!,
                                      );
                                      await widget.refresh();
                                      showSnackBar(context, "Club approved.");
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: "Reject",
                              child: IconButton(
                                onPressed: () async {
                                  // Handle reject invitation
                                  await ClubController.rejectClub(
                                      clubID: widget.club.id!);
                                  await widget.refresh();
                                  showSnackBar(context, "Club rejected.");
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
