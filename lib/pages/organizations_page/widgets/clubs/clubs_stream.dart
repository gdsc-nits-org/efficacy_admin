import 'package:efficacy_admin/controllers/services/services.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/pages/club/club_page.dart';
import 'package:flutter/material.dart';

class ClubsStream extends StatefulWidget {
  const ClubsStream({
    super.key,
  }); // Size constants
  static const double bigFontSize = 18;
  static const double smallFontSize = 14;
  static const double elevation = 5;
  static const double smallPadding = 8;
  static const double largePadding = 16;
  static const double imageWidth = 40;

  @override
  State<ClubsStream> createState() => ClubsStreamState();
}

class ClubsStreamState extends State<ClubsStream> {
  late List<ClubModel> clubs;

  Future<void> refreshClubs() async {
    await Future.delayed(Duration(seconds: 2));

    clubs = UserController.clubs;
  }

  List<Widget> buildClubs(List<ClubModel> clubs) {
    List<Widget> children = [];
    for (int index = 0; index < clubs.length; index++) {
      final club = clubs[index];
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: ClubsStream.smallPadding),
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                  left: ClubsStream.smallPadding,
                  right: ClubsStream.largePadding,
                  top: ClubsStream.largePadding,
                  bottom: ClubsStream.largePadding),
              title: Text(
                club.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Institute: ${club.instituteName}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Email: ${club.email}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
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
                    if (newClubDetails != null && newClubDetails is ClubModel) {
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
                  width: ClubsStream.imageWidth,
                  // Adjust the width as needed
                  height: ClubsStream.imageWidth,
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
    List<ClubModel> clubs = UserController.clubs;
    return (clubs.isNotEmpty)
        ? SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: buildClubs(clubs)),
          )
        : Text("You are in no club");
  }
}
