import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showEditClubTutorial(
  BuildContext context,
  GlobalKey editClubKey,
  GlobalKey editClubPositionKey, {
  void Function()? onFinish,
}) {
  List<TargetFocus> targets = getEditClubTargets(
    context,
    editClubKey,
    editClubPositionKey,
  );

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
  ).show(context: context);
}

void showInviteTutorial(
  BuildContext context,
  GlobalKey inviteKey, {
  void Function()? onFinish,
}) {
  List<TargetFocus> targets = getInviteTutorial(context, inviteKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
  ).show(context: context);
}

List<TargetFocus> getEditClubTargets(
  BuildContext parentContext,
  GlobalKey editClubKey,
  GlobalKey editClubPositionKey,
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
              parentContext: parentContext,
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
              parentContext: parentContext,
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
  ];
}

List<TargetFocus> getInviteTutorial(
  BuildContext parentContext,
  GlobalKey inviteKey,
) {
  return [
    TargetFocus(
      identify: "Invite",
      keyTarget: inviteKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
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
