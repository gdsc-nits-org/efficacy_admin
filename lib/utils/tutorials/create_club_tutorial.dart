import 'package:efficacy_admin/widgets/coach_mark_desc/coach_mark_desc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showCreateClubTutorial(
  BuildContext context,
  GlobalKey editImageKey,
  GlobalKey editBannerKey,
  GlobalKey createKey, {
  void Function()? onFinish,
}) {
  List<TargetFocus> targets =
      getCreateClubTargets(editImageKey, editBannerKey, createKey);

  TutorialCoachMark(
    hideSkip: true,
    useSafeArea: true,
    targets: targets, // List<TargetFocus>
    onFinish: onFinish,
  ).show(context: context);
}

List<TargetFocus> getCreateClubTargets(
  GlobalKey editImageKey,
  GlobalKey editBannerKey,
  GlobalKey createKey,
) {
  return [
    TargetFocus(
      identify: "Edit Club Image",
      keyTarget: editImageKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Club Image",
              text: "Click here to edit club image.",
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
      identify: "Edit Club Banner",
      keyTarget: editBannerKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Edit Club Banner",
              text: "Click to edit club banner.",
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
      identify: "Create",
      keyTarget: createKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return CoachmarkDesc(
              heading: "Create",
              text: "Click here to create club.",
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
