import 'dart:math';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:flutter/material.dart';

class MembersOverlay extends StatefulWidget {
  final ClubModel? club;
  final ClubPositionModel? clubPosition;

  const MembersOverlay({super.key, required this.club, this.clubPosition});

  @override
  State<MembersOverlay> createState() => _MembersOverlayState();
}

class _MembersOverlayState extends State<MembersOverlay> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> members = widget.club!.members[widget.clubPosition?.id] ?? [];
    return SizedBox(
      width: min(400, size.width * .8),
      height: min(400 * 1.5, size.height * .8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("${widget.clubPosition!.position} Members",style: const TextStyle(fontSize: 20,color: dark),),
                Expanded(
                  child: members.isNotEmpty
                      ? ListView.builder(                    
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            String memberEmail = members[index];
                            return ListTile(
                              title: Text(memberEmail),
                              // Other details or actions related to the member
                            );
                          },
                        )
                      : const Center(child: Text("No members",style: TextStyle(fontSize: 18.0),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
