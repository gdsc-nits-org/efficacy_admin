import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'stats_info.dart';
import 'package:flutter/material.dart';


class EventStats extends StatefulWidget {
  const EventStats({super.key, required this.currentEvent});

  final EventModel currentEvent;

  @override
  State<EventStats> createState() => _EventStatsState();
}

class _EventStatsState extends State<EventStats> {
  int likeCount = 0;
  bool isLiked = false;

@override
  void initState() {
    super.initState();
    likeCount = widget.currentEvent.liked.length;
  }
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

  Widget likeCountWidget() {
    return Text(likeCount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => toggleLike(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: dark, width: 2),
              borderRadius: BorderRadius.circular(20)  
            ),
            height: 50,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  isLiked
                      ? const Icon(
                          Icons.thumb_up,
                          color: dark,
                          size: 30,
                        )
                      : const Icon(
                          Icons.thumb_up_outlined,
                          color: dark,
                          size: 30,
                        ),

                const StatsInfo(
                  message: "Like",//"$likeCount",
                ),
              ].separate(10),
            ),
          ),
        ),
        InkWell(
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: dark, width: 2),
              borderRadius: BorderRadius.circular(20)  
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  const Icon(
                    Icons.share, 
                    color: dark,
                    size: 30,
                  ),
        
                const StatsInfo(message: "Share")
              ].separate(10),
            ),
          ),
        )
      ].separate(40),
    );
  }
}
