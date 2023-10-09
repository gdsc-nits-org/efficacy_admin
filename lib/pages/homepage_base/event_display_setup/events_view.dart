import 'package:efficacy_admin/pages/homepage_base/event_display_setup/event_widget.dart';
import 'package:flutter/material.dart';

class EventViewer extends StatelessWidget {
  const EventViewer({super.key, required this.typeIndex});

  final int typeIndex;

  @override
  Widget build(BuildContext context) {
    return EventDisplayWidget(typeIndex: typeIndex);
  }
}
