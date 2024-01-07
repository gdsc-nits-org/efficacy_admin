import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../utils/utils.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.item,
  });
  final EventModel? item;
  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          children: [
            const Gap(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: item?.posterURL == null || item!.posterURL.isEmpty
                  ? Image.asset(
                      Assets.mediaImgPath,
                      fit: BoxFit.cover,
                    )
                  : CustomNetworkImage(url: item!.posterURL),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 28.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item!.title,
                  style: const TextStyle(
                    color: Color.fromARGB(253, 82, 81, 81),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                bottom: 25.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.calendar,
                        color: shadow,
                        size: 16,
                      ),
                      Text(
                        "${_dateFormatter.format(item!.startDate)} - ${_dateFormatter.format(item!.endDate)}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: shadow,
                        ),
                      ),
                    ].separate(10),
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.clock,
                        color: shadow,
                        size: 16,
                      ),
                      Text(
                        Formatter.timeOnly(item!.startDate),
                        style: const TextStyle(
                          fontSize: 15,
                          color: shadow,
                        ),
                      ),
                    ].separate(10),
                  ),
                ].separate(15),
              ),
            )
          ].separate(5),
        ),
      ),
    );
  }
}
