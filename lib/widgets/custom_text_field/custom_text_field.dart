import 'package:efficacy_admin/config/config.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final EdgeInsets? contentPadding;
  final String? initialValue;
  final TextEditingController? controller;
  final String? title;
  final bool enabled;
  final Function? validator;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool hiddenText;
  final double height;
  final TextInputType keyboardType;
  final String? label;
  const CustomTextField({
    super.key,
    this.contentPadding,
    this.initialValue,
    this.controller,
    this.title,
    this.enabled = true,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.hiddenText = false,
    this.height = 40,
    this.keyboardType = TextInputType.emailAddress,
    this.label,
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
          height: height,
          child: TextFormField(
            keyboardType: keyboardType,
            obscureText: hiddenText,
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              focusColor: const Color(0xFF05354C),
              contentPadding:
                  contentPadding ?? const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              prefixIcon: Icon(prefixIcon, color: const Color.fromARGB(255, 67, 67, 67)),//const Color(0xFF05354C),),
              suffixIcon: suffixIcon,
            ),
            validator:(value)=>
              validator!(value),
            enabled: enabled,
            initialValue: initialValue,
          ),
        ),
      ].separate(3),
    );
  }
}
