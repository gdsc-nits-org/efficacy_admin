import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/services.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:flutter/material.dart';

class ClubsStream extends StatefulWidget {
  final double maxHeight;

  const ClubsStream({
    super.key,
    required this.maxHeight,
  }); // Size constants
  static const double bigFontSize = 18;
  static const double smallFontSize = 14;
  static const double elevation = 5;
  static const double smallPadding = 8;
  static const double largePadding = 16;
  static const double imageWidth = 40;

  @override
  State<ClubsStream> createState() => _ClubsStreamState();
}

class _ClubsStreamState extends State<ClubsStream> {
  List<ClubModel> clubs = UserController.clubs;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      child: (clubs.isNotEmpty)
          ? ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      top: ClubsStream.smallPadding,
                      bottom: ClubsStream.smallPadding),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
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
                    onTap: () {},
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
                );
              },
            )
          : const Text("You are in no club"),
    );
  }
}
