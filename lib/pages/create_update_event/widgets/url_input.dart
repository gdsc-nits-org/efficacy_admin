import 'package:flutter/material.dart';

class UrlInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final String? Function(String?) validator;
  final bool enabled;

  const UrlInput({
    super.key,
    required this.enabled,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.validator,
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
        enabled: enabled,
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: borderWidth),
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
