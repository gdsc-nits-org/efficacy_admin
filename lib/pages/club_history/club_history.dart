import 'package:efficacy_admin/controllers/services/club/club_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/pages/club/club_page.dart';
import 'package:efficacy_admin/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:efficacy_admin/widgets/custom_drawer/custom_drawer.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InteractionHistory extends StatefulWidget {
  const InteractionHistory({super.key});
  static const String routeName = "/interactionHistory";
  static const double bigFontSize = 18;
  static const double smallFontSize = 14;
  static const double elevation = 5;
  static const double smallPadding = 8;
  static const double largePadding = 16;
  static const double largePaddinginvites = 10;
  static const double imageWidth = 40;
  @override
  State<InteractionHistory> createState() => _InteractionHistoryState();
}

class _InteractionHistoryState extends State<InteractionHistory> {
  Future<void> _refresh() async {
    await UserController.updateUserData();
    setState(() {});
  }

  List<Widget> buildClubs(List<ClubModel> clubs) {
    List<Widget> children = [];
    for (int index = 0; index < clubs.length; index++) {
      final club = clubs[index];
      children.add(
        (club.clubStatus == ClubStatus.requested)
            ? Padding(
                padding: const EdgeInsets.only(
                    bottom: InteractionHistory.smallPadding),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClubPage(
                          createMode: false,
                          club: club,
                        ),
                      ),
                    ).then(
                      (dynamic newClubDetails) {
                        if (newClubDetails != null &&
                            newClubDetails is ClubModel) {
                          setState(() {
                            UserController.clubs[index] = newClubDetails;
                          });
                        }
                      },
                    );
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: InteractionHistory.largePaddinginvites,
                          left: InteractionHistory.largePaddinginvites,
                          top: InteractionHistory.largePaddinginvites,
                          bottom: InteractionHistory.largePaddinginvites),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Image(
                                  image: NetworkImage(club.clubLogoURL),
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.people),
                                  width: InteractionHistory.imageWidth,
                                  // Adjust the width as needed
                                  height: InteractionHistory.imageWidth,
                                  // Adjust the height as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(20),
                              Text(
                                club.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
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
                                  'Institute: ${club.instituteName}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Email: ${club.email}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Status: ${club.clubStatus}',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Gap(5),
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
                                                  clubID: club.id!);
                                              await _refresh();
                                              showSnackBar(context,
                                                  "Welcome to the club");
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
                                              clubID: club.id!);
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
              )
            : Padding(
                padding: const EdgeInsets.only(
                    bottom: InteractionHistory.smallPadding),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: InteractionHistory.smallPadding,
                        right: InteractionHistory.largePadding,
                        top: InteractionHistory.largePadding,
                        bottom: InteractionHistory.largePadding),
                    title: Text(
                      club.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Institute: ${club.instituteName}',
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Email: ${club.email}',
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Status: ${club.clubStatus}',
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubPage(
                            createMode: false,
                            club: club,
                          ),
                        ),
                      ).then(
                        (dynamic newClubDetails) {
                          if (newClubDetails != null &&
                              newClubDetails is ClubModel) {
                            setState(() {
                              UserController.clubs[index] = newClubDetails;
                            });
                          }
                        },
                      );
                    },
                    leading: ClipOval(
                      child: Image(
                        image: NetworkImage(club.clubLogoURL),
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.people),
                        width: InteractionHistory.imageWidth,
                        // Adjust the width as needed
                        height: InteractionHistory.imageWidth,
                        // Adjust the height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: "Clubs",
        ),
        endDrawer: CustomDrawer(pageContext: context),
        body: SingleChildScrollView(
          child: Column(
            children: buildClubs(UserController.clubs),
          ),
        ));
  }
}
