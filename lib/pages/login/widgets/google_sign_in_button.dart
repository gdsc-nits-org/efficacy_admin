import 'dart:math';

import 'package:flutter/material.dart';
import 'package:efficacy_admin/config/config.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: min(250, size.width * 0.8),
        child: OutlinedButton(
          onPressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                Assets.googleLogoImagePath,
                height: 40,
              ),
              Text(
                "Sign In with Google",
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
