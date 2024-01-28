import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showClubPageTutorial(
  BuildContext context,
  GlobalKey editClubKey,
  GlobalKey editClubPositionKey,
  GlobalKey inviteKey,
) {
  List<TargetFocus> targets = getTargets(
    editClubKey,
    editClubPositionKey,
    inviteKey,
  );

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getTargets(
  GlobalKey editClubKey,
  GlobalKey editClubPositionKey,
  GlobalKey inviteKey,
) {
  return [
    TargetFocus(
      identify: "Edit Club",
      keyTarget: editClubKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Club",
              text: "Click here to edit club.",
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
      identify: "Edit Club Position",
      keyTarget: editClubPositionKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Club Position",
              text:
                  "Click to create and edit club positions and also view members in different positions of the club.",
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
      identify: "Invite",
      keyTarget: inviteKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Invite",
              text: "Click here to invite new members to the club.",
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
