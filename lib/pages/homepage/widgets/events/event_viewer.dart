import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/widgets/custom_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventViewer extends StatelessWidget {
  final List<EventModel> events;
  final int typeIndex;
  const EventViewer({
    super.key,
    required this.typeIndex,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    List<EventModel> specificList = events
        .where((element) => Status.values.indexOf(element.type) == typeIndex)
        .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: specificList.length,
        itemBuilder: (context, index) {
          final item = specificList[index];
          return GestureDetector(
            onTap: () {}, // to card_pressed_screen
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CustomNetworkImage(
                        posterUrl: item.posterURL,
                        defaultUrl: "",
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          color: Color(0xFF05354C),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ExpandableNotifier(
                      child: Column(
                        children: [
                          Expandable(
                            collapsed: Text(
                              item.shortDescription,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            expanded: Text(item.shortDescription),
                          ),
                          Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      controller.toggle();
                                    },
                                    child: Text(
                                      controller!.expanded
                                          ? "Show less"
                                          : "Read more",
                                      style: const TextStyle(
                                        color: Color(0xFF05354C),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    AppBar(
                      leading: const Icon(CupertinoIcons.calendar),
                      title: Text(
                        "${Formatter.dateTime(item.startDate)} - ${Formatter.dateTime(item.endDate)}",
                        style: const TextStyle(fontSize: 13),
                      ),
                    )
                  ].separate(5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
