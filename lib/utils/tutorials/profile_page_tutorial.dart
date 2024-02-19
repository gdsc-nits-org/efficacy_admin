import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showProfilePageTutorial(
  BuildContext context,
  GlobalKey editProfileKey,
  GlobalKey delProfileKey,
  ScrollController scrollController, {
  void Function()? onFinish,
  bool Function()? onSkip,
}) {
  List<TargetFocus> targets = getProfilePageTargets(
    context,
    editProfileKey,
    delProfileKey,
    scrollController,
  );
  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
    onSkip: onSkip,
  ).show(context: context);
}

List<TargetFocus> getProfilePageTargets(
  BuildContext parentContext,
  GlobalKey editProfileKey,
  GlobalKey delProfileKey,
  ScrollController scrollController,
) {
  return [
    TargetFocus(
      identify: "Edit Profile",
      keyTarget: editProfileKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Edit Profile",
              text: "Click here to edit your profile details.",
              onNext: () {
                RenderBox renderBox = delProfileKey.currentContext!
                    .findRenderObject() as RenderBox;
                Offset position = renderBox.localToGlobal(Offset.zero);
                scrollController.animateTo(
                  position.dy,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutExpo,
                );
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
      identify: "Delete Profile",
      keyTarget: delProfileKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              parentContext: parentContext,
              heading: "Delete Profile",
              text: "Click here to delete your profile.",
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
