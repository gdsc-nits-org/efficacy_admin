import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/pages/homepage_base/navigation_tabs_setup/tab_list.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:efficacy_admin/pages/homepage_base/event_display_setup/event_list.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/pages/homepage_base/event_display_setup/dates.dart';

class EventDisplayWidget extends StatelessWidget {
  const EventDisplayWidget({super.key, required this.typeIndex});

  final int typeIndex;

  @override
  Widget build(BuildContext context) {
    List<EventModel> specificList = eventList
        .where((element) => tabList.indexOf(element.type) == typeIndex)
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
                    // loadImage(posterUrl: item.posterURL, defaultUrl: ""),
                    Align(
                      alignment: Alignment.centerLeft,
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
                        "${formattedDateTime(item.startDate)} - ${formattedDateTime(item.endDate)}",
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
