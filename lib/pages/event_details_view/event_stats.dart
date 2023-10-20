import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/pages/event_details_view/stats_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventStats extends StatefulWidget {
  const EventStats({super.key, required this.currentEventDate});

  final DateTime currentEventDate;

  @override
  State<EventStats> createState() => _EventStatsState();
}

class _EventStatsState extends State<EventStats> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton(
              onPressed: toggleLike,
              icon: isLiked
                  ? const Icon(
                      Icons.thumb_up,
                      color: light,
                    )
                  : const Icon(
                      Icons.thumb_up_outlined,
                    ),
            ),
            StatsInfo(
              message: "$likeCount",
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              CupertinoIcons.calendar,
              color: dark,
              size: 40,
            ),
            StatsInfo(
              message: DateFormat("d MMM").format(widget.currentEventDate),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            const StatsInfo(message: "Share")
          ],
        )
      ].separate(35),
    );
  }
}
