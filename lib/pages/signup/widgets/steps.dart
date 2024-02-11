import 'package:easy_stepper/easy_stepper.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class Steps extends StatefulWidget {
  final int activeStep;
  final bool takeStep;
  final void Function(int step) onPressedStep;
  final void Function(int index) onStepReached;
  const Steps({
    super.key,
    required this.activeStep,
    required this.takeStep,
    required this.onPressedStep,
    required this.onStepReached,
  });

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double vMargin = width * 0.16;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: vMargin * 0.5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: EasyStepper(
            stepRadius: 22,
            activeStep: widget.activeStep,
            steps: [
              EasyStep(
                customStep: IconButton(
                  onPressed: () => widget.onPressedStep(0),
                  icon: const Icon(Icons.person),
                ),
                customTitle: const Text(
                  'Credetials',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              EasyStep(
                customStep: IconButton(
                  onPressed: () => widget.onPressedStep(1),
                  icon: const Icon(Icons.verified),
                ),
                customTitle: const Text(
                  'Verification Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                )
              ),
              EasyStep(
                customStep: IconButton(
                    onPressed: () => widget.onPressedStep(2),
                    icon: const Icon(Icons.group)),
                customTitle: const Text(
                  "Personal Info",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              EasyStep(
                customStep: IconButton(
                    onPressed: () => widget.onPressedStep(3),
                    icon: const Icon(Icons.miscellaneous_services)),
                customTitle: const Text(
                  "Misc",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
            steppingEnabled: widget.takeStep,
            onStepReached: widget.onStepReached,
          ),
        ),
        // Gap(gap),
      ].separate(gap),
    );
  }
}
