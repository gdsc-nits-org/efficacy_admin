import 'package:flutter/material.dart';

Future<void> showReportBugTutorial(BuildContext context) async {
  await showDialog(
    barrierDismissible: true,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return OverlayScaleAnimation(
        child: AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Continue"),
            )
          ],
          title: Text(
            "Report Bug",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: RichText(
            text: TextSpan(
              text:
                  "A new UI will appear now.\n\nYou will see two options namely ",
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: "Navigate ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: "and",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: " Draw. ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text:
                      "Use the Navigate button to go into navigation mode where you will be able to navigate through pages.\n\nThe Draw button allows you to draw on the screen to mark the position as per your requirement.\n\nAfter that at the bottom you can type your issue and press the submit button. We will be happy to review those.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text:
                      "\n\nPlease note that your identity will be kept anonymous. We will just collect the feedback, along with you device information.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class OverlayScaleAnimation extends StatefulWidget {
  final Widget child;
  const OverlayScaleAnimation({
    super.key,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => OverlayScaleAnimationState();
}

class OverlayScaleAnimationState extends State<OverlayScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutExpo);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: widget.child,
    );
  }
}
