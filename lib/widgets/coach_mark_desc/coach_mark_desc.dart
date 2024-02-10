import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc({
    super.key,
    required this.heading,
    this.text,
    this.skip = "Skip",
    this.next = "Next",
    this.onSkip,
    this.onNext,
    required this.parentContext,
  });
  final BuildContext parentContext;
  final String heading;
  final String? text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;

  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}

class _CoachmarkDescState extends State<CoachmarkDesc>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 20,
      duration: const Duration(milliseconds: 800),
    )..repeat(min: 0, max: 20, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double gap = 8.0;
    return Theme(
      data: Theme.of(widget.parentContext),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, animationController.value),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.heading,
                style: Theme.of(widget.parentContext).textTheme.bodyLarge,
              ),
              if (widget.text != null)
                Text(
                  widget.text!,
                  style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: widget.onSkip,
                      child: Text(widget.skip),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: widget.onNext,
                      child: Text(widget.next),
                    ),
                  ),
                ],
              )
            ].separate(gap),
          ),
        ),
      ),
    );
  }
}
