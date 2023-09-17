import 'package:flutter/material.dart';
import 'package:efficacy_admin/pages/homepage_base/event_list.dart';

class EventViewer extends StatelessWidget {
  const EventViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: eventList,
      ),
    );
  }
}
