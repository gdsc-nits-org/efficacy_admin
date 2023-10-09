import 'package:flutter/cupertino.dart';

Widget loadImage({required String posterUrl, required String defaultUrl}) {
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
