import 'package:easy_stepper/easy_stepper.dart';
import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSteps extends StatelessWidget {
  final int activeStep;

  /// Whether the stepping is enabled or disabled.
  final bool takeStep;
  final void Function(int step) onPressedStep;
  final void Function(int index) onStepReached;
  const ForgotPasswordSteps({
    super.key,
    required this.activeStep,
    required this.takeStep,
    required this.onPressedStep,
    required this.onStepReached,
  });

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
            activeStep: activeStep,
            steps: [
              EasyStep(
                customStep: IconButton(
                  onPressed: () => onPressedStep(0),
                  icon: const Icon(Icons.email),
                ),
                customTitle: const Text(
                  'Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              EasyStep(
                  customStep: IconButton(
                    onPressed: () => onPressedStep(1),
                    icon: const Icon(Icons.verified),
                  ),
                  customTitle: const Text(
                    'Verification Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  )),
              EasyStep(
                customStep: IconButton(
                    onPressed: () => onPressedStep(2),
                    icon: const Icon(Icons.password)),
                customTitle: const Text(
                  "Credentials",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
            steppingEnabled: takeStep,
            onStepReached: onStepReached,
          ),
        ),
        // Gap(gap),
      ].separate(gap),
    );
  }
}
