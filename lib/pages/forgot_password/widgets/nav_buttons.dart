import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordNavButtons extends StatelessWidget {
  final int activeStep;
  final void Function(int index) onPressedBack;
  final void Function(int index) onPressedNext;
  const ForgotPasswordNavButtons({
    super.key,
    required this.activeStep,
    required this.onPressedBack,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () => onPressedBack(activeStep),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back_sharp,
                    ),
                    Gap(MediaQuery.of(context).size.width * 0.005),
                    const Text("Back"),
                  ],
                ),
              )),
        ),
        Gap(MediaQuery.of(context).size.width * 0.06),
        Expanded(
          child: Container(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.01),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => onPressedNext(activeStep),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(activeStep == 2 ? "Continue" : "Next"),
                    Gap(MediaQuery.of(context).size.width * 0.01),
                    const Icon(
                      Icons.arrow_forward_sharp,
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
