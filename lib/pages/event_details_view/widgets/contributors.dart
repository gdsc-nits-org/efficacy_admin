import 'package:efficacy_admin/config/configurations/theme/utils/palette.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';

class Contributors extends StatelessWidget {
  const Contributors({
    super.key,
    required this.contacts,
    required this.role,
  });
  final List<String> contacts;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          role,
          style: const TextStyle(
              color: dark, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Column(
          children: contacts.map((contact) {
            return StreamBuilder(
                stream: UserController.get(email: contact),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    UserModel user = snapshot.data.first;
                    return Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      surfaceTintColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            ProfileImageViewer(
                              imagePath: user.userPhoto,
                              height: 40,
                              enabled: false
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: dark),
                                ),
                                Text(
                                  user.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: dark),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                    return Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: dark),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                });
          }).toList(),
        )
      ],
    );
  }
}
