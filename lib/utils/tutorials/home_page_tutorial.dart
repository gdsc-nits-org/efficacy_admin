import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showHomePageTutorial(
  BuildContext context,
  GlobalKey listEventsKey,
  GlobalKey drawerKey,
  GlobalKey feedKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getHomePageTargets(
    context,
    listEventsKey,
    drawerKey,
    feedKey,
  );

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

void showCreateEventTutorial(
  BuildContext context,
  GlobalKey createEventKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getCreateEventTargets(context, createEventKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getHomePageTargets(
  BuildContext parentContext,
  GlobalKey listEventsKey,
  GlobalKey drawerKey,
  GlobalKey feedKey,
) {
  return [
    TargetFocus(
      identify: "List of Events",
      keyTarget: listEventsKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "List of events",
              text:
                  "This shows the list of events categorized into upcoming,ongoing and completed events.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Drawer",
      keyTarget: drawerKey,
      contents: [
        TargetContent(
          // align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Menu",
              text: "Click to navigate between pages and see more options.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        )
      ],
    ),
    TargetFocus(
      identify: "Feed",
      keyTarget: feedKey,
      contents: [
        TargetContent(
          customPosition: CustomTargetContentPosition(top: 18),
          align: ContentAlign.custom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Feed",
              text:
                  "This is where you can view different events in a category. Pull down to refresh the feed.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        ),
      ],
    ),
  ];
}

List<TargetFocus> getCreateEventTargets(
  BuildContext parentContext,
  GlobalKey createEventKey,
) {
  return [
    TargetFocus(
      identify: "Create Event",
      keyTarget: createEventKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Create Event",
              text: "This is where you can create new event.",
              onNext: () {
                controller.next();
              },
              onSkip: () {
                controller.skip();
              },
            );
          },
        ),
      ],
    ),
  ];
}
