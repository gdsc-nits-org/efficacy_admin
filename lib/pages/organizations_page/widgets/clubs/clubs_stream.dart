import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/club_position/club_position_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

Widget buildClubsStream(double maxHeight) {
  return StreamBuilder(
    stream: ClubPositionController.get(clubID: UserController.currentUser?.id),
    initialData: const [ClubPositionModel(clubID: "GDSC", position: "Lead")],
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Loading state
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Error state
        showErrorSnackBar(context, 'Error: ${snapshot.error}');
        return Text("Error: ${snapshot.error}");
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        // Empty data state
        return const Text('No club positions available.');
      } else {
        // Data available
        final clubPositions = snapshot.data!;
        return ListView.builder(
          itemCount: clubPositions.length,
          itemBuilder: (context, index) {
            final clubPosition = clubPositions[index];
            return ListTile(
              selectedTileColor: dark,
              selectedColor: light,
              selected: false,
              textColor: dark,
              tileColor: light,
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              title: Text('Club: ${clubPosition.clubID}'),
              subtitle: Text('Position: ${clubPosition.position}'),
            );
          },
        );
      }
    },
  );
}
