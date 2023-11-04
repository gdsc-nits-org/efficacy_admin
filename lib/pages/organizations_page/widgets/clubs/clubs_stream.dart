import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/club/club_controller.dart';
import 'package:efficacy_admin/models/club/club_model.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

// Size constants
const double bigFontSize = 18;
const double smallFontSize = 14;
const double elevation = 5;

Widget buildClubsStream(double maxHeight) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxHeight: maxHeight),
    child: StreamBuilder<List<ClubModel>>(
      stream: ClubController.get(instituteName: "NIT Silchar"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Error state
          showErrorSnackBar(context, 'Error: ${snapshot.error}');
          throw Exception('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Empty data state
          return const Text('No clubs available for NIT Silchar');
        } else {
          // Data available
          final clubs = snapshot.data!;
          return ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              final club = clubs[index];
              return Card(
                color: light,
                elevation: elevation,
                surfaceTintColor: dark,
                shadowColor: dark,
                child: ListTile(
                  title: Text(
                    'Club: ${club.name}',
                    style: const TextStyle(
                      fontSize: bigFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Institute: ${club.instituteName}',
                        style: const TextStyle(
                          fontSize: smallFontSize,
                        ),
                      ),
                      Text(
                        'Description: ${club.description}',
                        style: const TextStyle(
                          fontSize: smallFontSize,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
                  leading: ClipOval(
                    child: Image(
                      image: NetworkImage(club.clubLogoURL),
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.people),
                      width: 50, // Adjust the width as needed
                      height: 50, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    ),
  );
}
