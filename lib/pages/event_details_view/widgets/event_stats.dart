import 'package:efficacy_admin/config/config.dart';
import 'stats_info.dart';
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
              ),
              onPressed: toggleLike,
              icon: isLiked
                  ? const Icon(
                      Icons.thumb_up,
                      color: dark,
                    )
                  : const Icon(
                      Icons.thumb_up_outlined,
                      color: dark,
                    ),
            ),
            StatsInfo(
              message: "$likeCount",
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: null,
              icon: const Icon(
                Icons.calendar_month,
                color: dark,
              ) 
            ),
            StatsInfo(
              message: DateFormat("d MMM").format(widget.currentEventDate),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.share, 
                color: dark,
              ),
            ),
            const StatsInfo(message: "Share")
          ],
        )
      ].separate(35),
    );
  }
}
