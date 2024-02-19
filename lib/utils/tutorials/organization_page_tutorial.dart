import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showOrganizationPageTutorial(
  BuildContext context,
  GlobalKey invitationsKey,
  GlobalKey clubsKey,
  GlobalKey createClubKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getOrganizationPageTargets(
    context,
    invitationsKey,
    clubsKey,
    createClubKey,
  );

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getOrganizationPageTargets(
  BuildContext parentContext,
  GlobalKey invitationsKey,
  GlobalKey clubsKey,
  GlobalKey createClubKey,
) {
  return [
    TargetFocus(
      identify: "Invitations",
      keyTarget: invitationsKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Invitations",
              text: "Your invitations to other clubs appear here.",
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
      identify: "Clubs",
      keyTarget: clubsKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Clubs",
              text: "The clubs you are a part of are listed here.",
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
      identify: "Create Club",
      keyTarget: createClubKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Create Club",
              text: "Click here to create a new club.",
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
