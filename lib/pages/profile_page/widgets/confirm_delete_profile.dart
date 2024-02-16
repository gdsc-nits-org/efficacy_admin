import 'package:efficacy_admin/controllers/controllers.dart';
import 'package:efficacy_admin/dialogs/loading_overlay/loading_overlay.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:efficacy_admin/widgets/snack_bar/error_snack_bar.dart';
import 'package:flutter/material.dart';

import '../../login/login_page.dart';

class ConfirmDelProfile extends StatefulWidget {
  const ConfirmDelProfile({super.key});

  @override
  State<ConfirmDelProfile> createState() => _ConfirmDelProfileState();
}

class _ConfirmDelProfileState extends State<ConfirmDelProfile> {
  final TextEditingController _passController = TextEditingController();

  bool hidePassword = true;
  IconData passVisibility = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double fieldHeight = height * 0.09;

    return AlertDialog(
      title: const Text('Confirm Profile Deletion'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Enter your password to delete:'),
          const SizedBox(height: 10),
          CustomTextField(
            label: "Password",
            height: fieldHeight,
            controller: _passController,
            hiddenText: hidePassword,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => Validator.isPasswordValid(value),
            suffixIcon: IconButton(
                onPressed: () {
                  if (passVisibility == Icons.visibility) {
                    setState(() {
                      passVisibility = Icons.visibility_off;
                      hidePassword = false;
                    });
                  } else {
                    setState(() {
                      passVisibility = Icons.visibility;
                      hidePassword = true;
                    });
                  }
                },
                icon: Icon(
                  passVisibility,
                  color: const Color.fromARGB(255, 67, 67, 67),
                )),
            prefixIcon: Icons.lock,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            List<UserModel> user = [];
            showLoadingOverlay(
                parentContext: context,
                asyncTask: () async {
                  user = await UserController.get(
                    email: UserController.currentUser!.email,
                    keepPassword: true,
                    forceGet: true,
                  ).first;

                  BuildContext dialogContext = context;
                  String enteredPassword = _passController.text;
                  if (Encryptor.isValid(
                          user.first.password!, enteredPassword) &&
                      mounted) {
                    showLoadingOverlay(
                      parentContext: context,
                      asyncTask: () async {
                        await UserController.delete();

                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginPage.routeName,
                              (route) => false,
                            );
                            showSnackBar(context, "Profile Deleted!");
                          }
                        });
                      },
                    );
                  } else {
                    if (!dialogContext.mounted) return;
                    Navigator.of(dialogContext).pop();
                    showSnackBar(context, "Invalid Password");
                  }
                });
          },
          child: const Text('Confirm', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
