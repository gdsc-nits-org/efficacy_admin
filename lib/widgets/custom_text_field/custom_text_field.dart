import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final String? title;
  final bool enabled;
  const CustomTextField({
    super.key,
    this.contentPadding,
    this.controller,
    this.title,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  contentPadding ?? const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            enabled: enabled,
          ),
        ),
      ].separate(3),
    );
  }
}
