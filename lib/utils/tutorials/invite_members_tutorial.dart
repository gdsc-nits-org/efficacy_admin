import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showSearchBarTutorial(
  BuildContext context,
  GlobalKey searchUserKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getSearchBarTarget(context, searchUserKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getSearchBarTarget(
  BuildContext parentContext,
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
              parentContext: parentContext,
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
  GlobalKey memberKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getUserTarget(context, memberKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getUserTarget(
  BuildContext parentContext,
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
              parentContext: parentContext,
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
  GlobalKey inviteKey, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getInviteButtonTarget(context, inviteKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getInviteButtonTarget(
  BuildContext parentContext,
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
              parentContext: parentContext,
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
