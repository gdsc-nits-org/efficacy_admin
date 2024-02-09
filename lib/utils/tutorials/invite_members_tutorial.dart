import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showSearchBarTutorial(
  BuildContext context,
  GlobalKey searchUserKey, {
  void Function()? onFinish,
}) {
  List<TargetFocus> targets = getSearchBarTarget(searchUserKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
  ).show(context: context);
}

List<TargetFocus> getSearchBarTarget(
  GlobalKey searchUserKey,
) {
  return [
    TargetFocus(
      identify: "Search",
      keyTarget: searchUserKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Search  User",
              text: "Type here to search user who you want to invite.",
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

void showSelectUserTutorial(
  BuildContext context,
  GlobalKey memberKey,
) {
  List<TargetFocus> targets = getUserTarget(memberKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getUserTarget(
  GlobalKey memKey,
) {
  return [
    TargetFocus(
      identify: "User",
      keyTarget: memKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Select user",
              text:
                  "Click to send invite to this user.\nLong press to select multiple users to send invite for a particular position.",
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

void showInviteButtonTutorial(
  BuildContext context,
  GlobalKey inviteKey,
) {
  List<TargetFocus> targets = getInviteButtonTarget(inviteKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
  ).show(context: context);
}

List<TargetFocus> getInviteButtonTarget(
  GlobalKey inviteKey,
) {
  return [
    TargetFocus(
      identify: "Invite Button",
      keyTarget: inviteKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Invite Button",
              text: "Click here to send invite.",
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
