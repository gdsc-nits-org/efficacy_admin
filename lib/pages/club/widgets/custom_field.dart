import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?) validator;
  final int? maxLines;
  final TextInputType? textInputType;
  final bool enabled;
  final String? initialValue;

  const CustomField({
    super.key,
    this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.validator,
    this.maxLines = 1,
    this.textInputType,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    //constants
    double borderWidth = 1;
    double boxRadius = 7;
    double iconSize = 25;
    double padding = 16;

    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: TextFormField(
        keyboardType: textInputType,
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        enabled: enabled,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: borderWidth),
            borderRadius: BorderRadius.all(Radius.circular(boxRadius)),
          ),
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            size: iconSize,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
