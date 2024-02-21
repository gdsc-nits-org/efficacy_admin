import 'package:efficacy_admin/controllers/services/services.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/pages/club/club_page.dart';
import 'package:flutter/material.dart';

class ClubsStream extends StatefulWidget {
  final List<ClubModel> clubs;
  const ClubsStream({
    super.key,
    required this.clubs,
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

  List<ClubModel> filter(){
    List<ClubModel> clubStatusAcceptedList = [];
    for(int i = 0; i < widget.clubs.length; i++){
      if(widget.clubs[i].clubStatus == ClubStatus.rejected||widget.clubs[i].clubStatus == ClubStatus.requested){
        continue;
      }
      clubStatusAcceptedList.add(widget.clubs[i]);
    }
    return clubStatusAcceptedList;
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
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Position: ${UserController.clubPositions.where((position) => position.clubID == club.id).map((position) => position.position).join(",")}",
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
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
    return (filter().isNotEmpty)
        ? Column(children: buildClubs(filter()))
        : const Text("You are in no club");
  }
}
