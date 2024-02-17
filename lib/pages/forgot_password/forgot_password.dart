import 'package:efficacy_admin/config/configurations/theme/utils/palette.dart';
import 'package:efficacy_admin/controllers/services/mail/mail_controller.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/controllers/services/verification_code/verification_code_controller.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/verification_code/verification_code_model.dart';
import 'package:efficacy_admin/pages/forgot_password/widgets/forgot_password_form/forgot_password_form.dart';
import 'package:efficacy_admin/pages/forgot_password/widgets/nav_buttons.dart';
import 'package:efficacy_admin/pages/pages.dart';
import 'package:efficacy_admin/utils/exit_program.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/steps.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/ForgotPasswordPage';
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  int activeStep = 0;
  bool takeStep = false;
  bool verificationCodeVerified = false;

  bool backButtonDisableChecker() {
    return activeStep == 0;
  }

  Future<void> generateAndSendCode() async {
    await showLoadingOverlay(
        parentContext: context,
        asyncTask: () async {
          if (await UserController.doesUserExists(
              email: emailController.text)) {
            VerificationCodeModel verificationCode =
                await VerificationCodeController.generateRandomCodeAndSave(
              len: 5,
              email: emailController.text,
              intent: VerificationCodeIntent.forgotPassword,
            );
            await MailController.sendForgotPasswordMail(
              code: verificationCode.code,
              email: verificationCode.email,
              expiresAt: verificationCode.expiresAt,
            );
            showSnackBar(context, "Please check your email for the code");
          } else {
            throw Exception("User doesn't exists. Please signup.");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double gap = height * 0.02;
    double formWidth = width * 0.8;
    double vMargin = width * 0.16;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showExitWarning(context);
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: vMargin),
            child: SizedBox(
                width: width,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Hey! We will help you get back to your clubs.",
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ForgotPasswordSteps(
                          activeStep: activeStep,
                          takeStep: takeStep,
                          onPressedStep: (int step) async {
                            if (_formKey.currentState!.validate() &&
                                (activeStep - step).abs() == 1) {
                              bool canMove = false;
                              if (activeStep != 1) {
                                canMove = true;
                              } else if (step == 0) {
                                canMove = true;
                              } else if (verificationCodeVerified) {
                                canMove = true;
                              }
                              if (canMove) {
                                setState(() {
                                  takeStep = true;
                                  activeStep = step;
                                });
                              }
                            }
                          },
                          onStepReached: (int index) {
                            setState(() {
                              activeStep = index;
                            });
                          },
                        ),
                        SizedBox(
                          width: formWidth,
                          child: ForgotPasswordForm(
                            step: activeStep,
                            verificationCodeVerified: verificationCodeVerified,
                            resendVerificationCode: generateAndSendCode,
                            emailController: emailController,
                            passwordController: passwordController,
                            confirmPasswordController:
                                confirmPasswordController,
                            verificationCodeController:
                                verificationCodeController,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                          width: formWidth,
                          child: ForgotPasswordNavButtons(
                            activeStep: activeStep,
                            onPressedBack: (int index) {
                              if (!backButtonDisableChecker()) {
                                setState(() {
                                  --activeStep;
                                });
                              }
                            },
                            onPressedNext: (int index) async {
                              if (_formKey.currentState!.validate()) {
                                if (index == 0 && !verificationCodeVerified) {
                                  await generateAndSendCode();

                                  setState(() {
                                    ++activeStep;
                                  });
                                } else if (index == 1 &&
                                    !verificationCodeVerified) {
                                  await showLoadingOverlay(
                                      parentContext: context,
                                      asyncTask: () async {
                                        await VerificationCodeController
                                            .verifyCode(
                                          code: verificationCodeController.text,
                                          email: emailController.text,
                                          intent: VerificationCodeIntent
                                              .forgotPassword,
                                        );
                                        verificationCodeVerified = true;

                                        setState(() {
                                          ++activeStep;
                                        });
                                      });
                                } else if (index == 2) {
                                  showLoadingOverlay(
                                      parentContext: context,
                                      asyncTask: () async {
                                        String userName =
                                            await UserController.resetPassword(
                                          email: emailController.text,
                                          newPassword: passwordController.text,
                                        );
                                        await MailController
                                            .sendPasswordResetAcknowledgementMail(
                                          email: emailController.text,
                                          userName: userName,
                                        );
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          if (mounted) {
                                            Navigator.of(context).pop();
                                            showSnackBar(context,
                                                "Password reset successfull");
                                          }
                                        });
                                      });
                                } else {
                                  setState(() {
                                    ++activeStep;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, SignUpPage.routeName);
                          },
                          child: RichText(
                            text: const TextSpan(
                                text: "Don't have an account? ",
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: dark,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark,
                                    ),
                                  )
                                ],
                                style: TextStyle(color: shadow)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
