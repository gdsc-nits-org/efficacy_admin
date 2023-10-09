import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String posterUrl;
  final String defaultUrl;
  const CustomNetworkImage({super.key,required this.posterUrl, required this.defaultUrl});

  @override
  Widget build(BuildContext context) {
    try {
      return Image.network(
        posterUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
            defaultUrl,
            fit: BoxFit.contain,
          );
        },
      );
    } catch (e) {
      return Image.network(
        defaultUrl,
        fit: BoxFit.contain,
      );
    }
  }
}
